extends Node

const max_track:int = 16
const max_channel:int = 16
const max_note_number:int = 128
const max_program_number:int = 128
const drum_track_channel:int = 0x09
const drum_track_bank:int = 128
const ADSR = preload( "ADSR.tscn" )
const SMF = preload( "SMF.gd" )
const SoundFont = preload( "SoundFont.gd" )
const Bank = preload( "Bank.gd" )

export (int, 0, 128) var max_polyphony:int = 64
export (String, FILE, "*.mid") var file:String = "" setget set_file
export (bool) var playing:bool = false
export (Array) var channel_mute:Array = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
export (float) var play_speed:float = 1.0
export (float, -1000, 0) var volume_db:float = -10
export (int) var key_shift:int = 0
export (bool) var loop:bool = false
export (float) var loop_start:float = 0
export (String, FILE, "*.sf2") var soundfont:String = ""
export (int, "MIX_TARGET_STEREO", "MIX_TARGET_SURROUND", "MIX_TARGET_CENTER") var mix_target:int = AudioStreamPlayer.MIX_TARGET_STEREO
export (String) var bus:String = "Master"

var smf_data = null
var tempo:float = 120 setget set_tempo
var frame_second:float = 0.0
var seconds_to_timebase:float = 2.3
var timebase_to_seconds:float = 1.0 / seconds_to_timebase
var position:float = 0
var last_position:int = 0
var track_status = null
var channel_status = []
var channel_volume_db:float = 20

var bank = null
var audio_stream_players = []

var _used_program_numbers = []

signal changed_tempo( tempo )
signal appeared_lyric( lyric )
signal appeared_marker( marker )
signal appeared_cue_point( cue_point )
signal midi_event( channel, event )
signal looped

func _ready( ):
	var fps:int = ProjectSettings.get_setting("debug/settings/fps/force_fps")
	if fps == 0: fps = 60
	self.frame_second = 1.0 / float(fps)

"""
	初期化
"""
func _prepare_to_play( ):
	# ファイル読み込み
	if self.smf_data == null:
		var smf_reader = SMF.new( )
		self.smf_data = smf_reader.read_file( self.file )

	self._init_track( )
	self._analyse_smf( )
	self._init_channel( )

	# 楽器
	if self.bank == null:
		self.bank = Bank.new( )
		self.bank.init( )
		if self.soundfont != "":
			var sf_reader = SoundFont.new( )
			var sf2 = sf_reader.read_file( self.soundfont )
			self.bank.read_soundfont( sf2, self._used_program_numbers )

	# 発音機
	if self.audio_stream_players.size( ) == 0:
		for i in range( self.max_polyphony ):
			var audio_stream_player = ADSR.instance( )
			audio_stream_player.mix_target = self.mix_target
			audio_stream_player.bus = self.bus
			self.add_child( audio_stream_player )
			self.audio_stream_players.append( audio_stream_player )
	else:
		for audio_stream_player in self.audio_stream_players:
			audio_stream_player.mix_target = self.mix_target
			audio_stream_player.bus = self.bus

"""
	トラック初期化
"""
func _init_track( ):
	self.track_status = {
		"events": [],
		"event_pointer": 0,
	}

	if self.smf_data == null:
		OS.alert("Invalid data")
		return

	if len( self.smf_data.tracks ) == 1:
		self.track_status.events = self.smf_data.tracks[0].events
	else:
		var tracks = []
		for track in self.smf_data.tracks:
			tracks.append({"pointer":0, "data":track})

		var time:int = 0
		while true:
			var finished:bool = true
			var next_time:int = 0x7fffffff
			for track in tracks:
				if len(track.data.events) <= track.pointer: continue
				
				var e = track.data.events[track.pointer]
				finished = false
				if e.time == time:
					self.track_status.events.append( e )
					track.pointer += 1
				if e.time < next_time:
					next_time = e.time
			time = next_time
			if finished: break

	self.last_position = self.track_status.events[len(self.track_status.events)-1].time

"""
	SMF解析
"""
func _analyse_smf( ):
	var channels = []
	for i in range( max_channel ):
		channels.append({
			#"note_on": {},
			#"program_number": 0,
			"number": i,
			"bank": 0,
		})
	self._used_program_numbers = []

	for event_chunk in self.track_status.events:
		var channel_number:int = event_chunk.channel_number
		var channel = channels[channel_number]
		var event = event_chunk.event

		match event.type:
			#SMF.MIDIEventType.note_off:
			#	channel.note_on.erase( event.note )
			#SMF.MIDIEventType.note_on:
			#	channel.note_on[event.note] = true
			SMF.MIDIEventType.program_change:
				var program_number:int = event.number | ( channel.bank << 7 )
				# channel.program_number = program_number
				if not( event.number in self._used_program_numbers ):
					self._used_program_numbers.append( event.number )
				if not( program_number in self._used_program_numbers ):
					self._used_program_numbers.append( program_number )
			SMF.MIDIEventType.control_change:
				match event.number:
					SMF.control_number_bank_select_msb:
						if channel.number == drum_track_channel:
							channel.bank = self.drum_track_bank
						else:
							channel.bank = ( channel.bank & 0x7F ) | ( event.value << 7 )
					SMF.control_number_bank_select_lsb:
						if channel.number == drum_track_channel:
							channel.bank = self.drum_track_bank
						else:
							channel.bank = ( channel.bank & 0x3F80 ) | ( event.value & 0x7F )
					SMF.control_number_tkool_loop_point:
						self.loop_start = float( event_chunk.time )

"""
	チャンネル初期化
"""
func _init_channel( ):
	self.channel_status = []
	for i in range( max_channel ):
		var drum_track:bool = ( i == drum_track_channel )
		var bank:int = 0
		if drum_track:
			bank = self.drum_track_bank
		self.channel_status.append({
			"number": i,
			"note_on": {},
			"bank": bank,
			"program": 0,
			"volume": 1.0,
			"expression": 1.0,
			"pitch_bend": 0.0,
			"drum_track": drum_track,
			"pan": 0.5,

			"rpn": {
				"selected_msb": 0,
				"selected_lsb": 0,

				"pitch_bend_range": 2.0,
				"pitch_bend_range_msb": 2.0,
				"pitch_bend_range_lsb": 0.0,
			},
		})

"""
	再生
	@param	from_position
"""
func play( from_position:float = 0 ):
	self._prepare_to_play( )
	self.playing = true
	if from_position == 0:
		self.position = 0
		self.track_status.event_pointer = 0
	else:
		self.seek( from_position )

"""
	シーク
"""
func seek( to_position:float ):
	self._stop_all_notes( )
	self.position = to_position

	var pointer:int = 0
	var length:int = len(self.track_status.events)
	while pointer < length:
		var event_chunk = self.track_status.events[pointer]
		if self.position <= event_chunk.time:
			break
		pointer += 1
	self.track_status.event_pointer = pointer

"""
	停止
"""
func stop( ):
	self._stop_all_notes( )
	self.playing = false

"""
	ファイル変更
"""
func set_file( path:String ):
	file = path
	self.smf_data = null
	self.bank = null

"""
	テンポ設定
"""
func set_tempo( bpm:float ):
	tempo = bpm
	self.seconds_to_timebase = tempo / 60.0
	self.timebase_to_seconds = 60.0 / tempo
	self.emit_signal( "changed_tempo", bpm )

"""
	全音を止める
"""
func _stop_all_notes( ):
	for audio_stream_player in self.audio_stream_players:
		audio_stream_player.stop( )

	for channel in self.channel_status:
		channel.note_on = {}

"""
	毎フレーム処理
"""
func _process( delta:float ):
	if self.smf_data == null:
		return
	if not self.playing:
		return

	self.position += float( self.smf_data.timebase ) * delta * self.seconds_to_timebase * self.play_speed
	self._process_track( )

"""
	トラック処理
"""
func _process_track( ):
	var track = self.track_status
	if track.events == null:
		return

	var length:int = len(track.events)

	if length <= track.event_pointer:
		if self.loop:
			self.seek( self.loop_start )
			self.emit_signal( "looped" )
		else:
			self.playing = false
		return

	for channel in self.channel_status:
		for key_number in channel.note_on.keys( ):
			var note_on = channel.note_on[key_number]
			if not note_on.playing:
				channel.note_on.erase( key_number )

	var execute_event_count:int = 0
	var current_position:int = int( self.position )

	while track.event_pointer < length:
		var event_chunk = track.events[track.event_pointer]
		if current_position < event_chunk.time:
			break
		track.event_pointer += 1
		execute_event_count += 1

		var channel = self.channel_status[event_chunk.channel_number]
		var event = event_chunk.event

		self.emit_signal( "midi_event", channel, event )

		match event.type:
			SMF.MIDIEventType.note_off:
				self._process_track_event_note_off( channel, event )
			SMF.MIDIEventType.note_on:
				self._process_track_event_note_on( channel, event )
			SMF.MIDIEventType.program_change:
				channel.program = event.number
			SMF.MIDIEventType.control_change:
				self._process_track_event_control_change( channel, event )
			SMF.MIDIEventType.pitch_bend:
				channel.pitch_bend = float( event.value ) / 8192.0 - 1.0
				self._update_pitch_bend_note( channel )
			SMF.MIDIEventType.system_event:
				self._process_track_system_event( channel, event )
			_:
				# 無視
				pass

	return execute_event_count

func _process_track_event_note_off( channel, event ):
	var key_number:int = event.note + self.key_shift
	if channel.note_on.has( key_number ):
		var note_player = channel.note_on[key_number]
		if note_player != null:
			note_player.start_release( )
			channel.note_on.erase( key_number )

func _process_track_event_note_on( channel, event ):
	if not self.channel_mute[channel.number]:
		var key_number:int = event.note + self.key_shift
		var note_volume:float = channel.volume * channel.expression * ( event.velocity / 127.0 )
		var volume_db:float = note_volume * self.channel_volume_db - self.channel_volume_db + self.volume_db
		var preset = self.bank.get_preset( channel.program, channel.bank )
		var instrument = preset.instruments[key_number]

		if instrument != null:
			if channel.note_on.has( key_number ):
				channel.note_on[key_number].start_release( )

			var note_player = self._get_idle_player( )
			if note_player != null:
				note_player.velocity = event.velocity
				note_player.maximum_volume_db = volume_db
				note_player.pitch_bend = channel.pitch_bend
				note_player.pitch_bend_range = channel.rpn.pitch_bend_range
				note_player.set_instrument( instrument )
				note_player.play( 0.0 )
				if not channel.drum_track:
					channel.note_on[key_number] = note_player

func _process_track_event_control_change( channel, event ):
	match event.number:
		SMF.control_number_volume:
			channel.volume = event.value / 127.0
			self._apply_channel_volume_to_notes( channel )
		SMF.control_number_expression:
			channel.expression = event.value / 127.0
			self._apply_channel_volume_to_notes( channel )
		SMF.control_number_pan:
			channel.pan = event.value / 127.0
		SMF.control_number_bank_select_msb:
			if channel.drum_track:
				channel.bank = self.drum_track_bank
			else:
				channel.bank = ( channel.bank & 0x7F ) | ( event.value << 7 )
		SMF.control_number_bank_select_lsb:
			if channel.drum_track:
				channel.bank = self.drum_track_bank
			else:
				channel.bank = ( channel.bank & 0x3F80 ) | ( event.value & 0x7F )
		SMF.control_number_rpn_lsb:
			channel.rpn.selected_lsb = event.value
		SMF.control_number_rpn_msb:
			channel.rpn.selected_msb = event.value
		SMF.control_number_data_entry_msb:
			self._process_track_event_control_change_rpn_data_entry_msb( channel, event )
		SMF.control_number_data_entry_lsb:
			self._process_track_event_control_change_rpn_data_entry_lsb( channel, event )
		_:
			# 無視
			pass

func _process_track_event_control_change_rpn_data_entry_msb( channel, event ):
	match channel.rpn.selected_msb:
		0:
			match channel.rpn.selected_lsb:
				SMF.rpn_control_number_pitch_bend_range:
					channel.rpn.pitch_bend_range_msb = float( event.value )
					if 12 < channel.rpn.pitch_bend_range_msb: channel.rpn.pitch_bend_range_msb = 12
					channel.rpn.pitch_bend_range = channel.rpn.pitch_bend_range_msb + channel.rpn.pitch_bend_range_lsb / 100.0
				_:
					pass
		_:
			pass

func _process_track_event_control_change_rpn_data_entry_lsb( channel, event ):
	match channel.rpn.selected_msb:
		0:
			match channel.rpn.selected_lsb:
				SMF.rpn_control_number_pitch_bend_range:
					channel.rpn.pitch_bend_range_lsb = float( event.value )
					channel.rpn.pitch_bend_range = channel.rpn.pitch_bend_range_msb + channel.rpn.pitch_bend_range_lsb / 100.0
				_:
					pass
		_:
			pass

func _process_track_system_event( channel, event ):
	match event.args.type:
		SMF.MIDISystemEventType.set_tempo:
			self.tempo = 60000000.0 / float( event.args.bpm )
		SMF.MIDISystemEventType.lyric:
			self.emit_signal( "appeared_lyric", event.args.text )
		SMF.MIDISystemEventType.marker:
			self.emit_signal( "appeared_marker", event.args.text )
		SMF.MIDISystemEventType.cue_point:
			self.emit_signal( "appeared_cue_point", event.args.text )
		_:
			# 無視
			pass

func _get_idle_player( ):
	var stopped_audio_stream_player = null
	var minimum_volume:float = 100.0
	var oldest_audio_stream_player = null
	var oldest:float = 0.0

	for audio_stream_player in self.audio_stream_players:
		if not audio_stream_player.playing:
			return audio_stream_player
		if audio_stream_player.releasing and audio_stream_player.current_volume < minimum_volume:
			stopped_audio_stream_player = audio_stream_player
			minimum_volume = audio_stream_player.current_volume
		if oldest < audio_stream_player.using_timer:
			oldest_audio_stream_player = audio_stream_player
			oldest = audio_stream_player.using_timer

	if stopped_audio_stream_player != null:
		return stopped_audio_stream_player

	return oldest_audio_stream_player

func _apply_channel_volume_to_notes( channel ):
	for note in channel.note_on.values( ):
		note.change_channel_volume( self.channel_volume_db, self.volume_db, channel )

func _update_pitch_bend_note( channel ):
	for note in channel.note_on.values( ):
		note.set_pitch_bend_range( channel.rpn.pitch_bend_range )
		note.set_pitch_bend( channel.pitch_bend )

"""
	現在発音中の音色数を返す
"""
func get_now_playing_polyphony( ):
	var polyphony:int = 0
	for audio_stream_player in self.audio_stream_players:
		if audio_stream_player.playing:
			polyphony += 1
	return polyphony
