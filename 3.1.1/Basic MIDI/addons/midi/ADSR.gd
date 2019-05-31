extends AudioStreamPlayer

"""
	AudioStreamPlayer with ADSR
"""

var releasing:bool = false
var request_release:bool = false
var instrument = null
var velocity:int = 0
var pitch_bend:float = 0
var pitch_bend_range:float = 12.0
var mix_rate:float = 0
var using_timer:float = 0.0
var timer:float = 0.0
var current_volume:float = 0.0
var maximum_volume_db:float = -8.0
var minimum_volume_db:float = -108.0
# var pan:float = 0.5
var ads_state = [
	{ "time": 0.0, "volume": 1.0 },
	{ "time": 0.2, "volume": 0.95 },
	# { "time": 0.2, "jump_to": 0.0 },	# not implemented
]
var release_state = [
	{ "time": 0.0, "volume": 0.8 },
	{ "time": 0.01, "volume": 0.0 },
	# { "time": 0.2, "jump_to": 0.0 },	# not implemented
]

func _ready( ):
	self.stop( )

func set_instrument( instrument ):
	self.instrument = instrument
	self.mix_rate = instrument.mix_rate
	self.stream = instrument.stream.duplicate( )
	self.ads_state = instrument.ads_state
	self.release_state = instrument.release_state

func play( from_position:float = 0.0 ):
	self.releasing = false
	self.request_release = false
	self.timer = 0.0
	self.using_timer = 0.0
	self.current_volume = self.ads_state[0].volume
	self.stream.mix_rate = self.mix_rate
	self.pitch_scale = pow( 2, self.pitch_bend * self.pitch_bend_range / 12.0 )
	.play( from_position )
	self._update_volume( )

func start_release( ):
	self.request_release = true

func set_pitch_bend( pb:float ):
	self.pitch_bend = pb
	var pos = self.get_playback_position( )
	self.pitch_scale = pow( 2, self.pitch_bend * self.pitch_bend_range / 12.0 )

func set_pitch_bend_range( pbr:float ):
	self.pitch_bend_range = pbr

func _process( delta:float ):
	if not self.playing:
		return

	self.timer += delta
	self.using_timer += delta
	# self.transform.origin.x = self.pan * self.get_viewport( ).size.x

	# ADSR
	var use_state = null
	if self.releasing:
		use_state = self.release_state
	else:
		use_state = self.ads_state

	var all_states:int = use_state.size( )
	var last_state:int = all_states - 1
	if use_state[last_state].time <= self.timer:
		self.current_volume = use_state[last_state].volume
		if self.releasing: self.stop( )
	else:
		for state_number in range( 1, all_states ):
			var state = use_state[state_number]
			if self.timer < state.time:
				var pre_state = use_state[state_number-1]
				var s:float = ( state.time - self.timer ) / ( state.time - pre_state.time )
				var t:float = 1.0 - s
				self.current_volume = pre_state.volume * s + state.volume * t
				break

	self._update_volume( )

	if self.request_release and not self.releasing:
		self.releasing = true
		self.current_volume = self.release_state[0].volume
		self.timer = 0.0

func _update_volume( ):
	var s:float = self.current_volume
	var t:float = 1.0 - s
	self.volume_db = s * self.maximum_volume_db + t * self.minimum_volume_db

func change_channel_volume( amp_volume_db:float, base_volume_db:float, channel ):
	var note_volume:float = channel.volume * channel.expression * ( self.velocity / 127.0 )
	var volume_db:float = note_volume * amp_volume_db - amp_volume_db + base_volume_db
	self.maximum_volume_db = volume_db
