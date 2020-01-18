extends Label

const INPUT_ACTIONS = ["LEFT", "RIGHT", "TOP", "DOWN", "ATTACK", "X"]

var action
var button

func _ready():
	var dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var config_file = ConfigFile.new()
	if config_file.load(dir + "/" + "Raul mission.cfg") == OK:
		Variables.volume_music = config_file.get_value("MUSIC", "music_volume", 0)
		Variables.volume_sounds = config_file.get_value("MUSIC", "sfx_volume", 0)
		
		SetSize(config_file.get_value("RESOLUTION", "resolution", 2))
		
		for action_name in config_file.get_section_keys("input"):
			var scancode = OS.find_scancode_from_string(config_file.get_value("input", action_name))
			var event = InputEventKey.new()
			event.scancode = scancode
			var name_key = OS.get_scancode_string(event.scancode)
			
			for old_event in InputMap.get_action_list(action_name):
				if old_event is InputEventKey:
					InputMap.action_erase_event(action_name, old_event)
			InputMap.action_add_event(action_name, event)
			print(action_name)
			if action_name != "ESC" and action_name != "ENTER":
				match(action_name):
					"ATTACK" : $Panel/ATTACK.text = name_key
					"X" : $Panel/X.text = name_key
					"UP" : $Panel/UP.text = name_key
					"DOWN" : $Panel/DOWN.text = name_key
					"LEFT" : $Panel/LEFT.text = name_key
					"RIGHT" : $Panel/RIGHT.text = name_key
	
	$Panel/LEFT.connect("pressed", self, "wait_for_input", ["LEFT"])
	$Panel/RIGHT.connect("pressed", self, "wait_for_input", ["RIGHT"])
	$Panel/UP.connect("pressed", self, "wait_for_input", ["UP"])
	$Panel/DOWN.connect("pressed", self, "wait_for_input", ["DOWN"])
	$Panel/ATTACK.connect("pressed", self, "wait_for_input", ["ATTACK"])
	$Panel/X.connect("pressed", self, "wait_for_input", ["X"])
	
	get_node("Panel/Size/1x").connect("pressed", self, "SetSize", [1])
	get_node("Panel/Size/2x").connect("pressed", self, "SetSize", [2])
	get_node("Panel/Size/3x").connect("pressed", self, "SetSize", [3])
	get_node("Panel/Size/4x").connect("pressed", self, "SetSize", [4])

	set_process_input(false)
	
	$"../Music".volume_db = Variables.volume_music
	AudioServer.set_bus_volume_db(1, Variables.volume_sounds)
	$Panel/MUSIC.value = Variables.volume_music
	$Panel/SFX.value = Variables.volume_sounds


func wait_for_input(arg):
	button = arg
	$Panel/Info.text = "Press a key"
	set_process_input(true)


func _input(event):
	
	if event is InputEventKey:
		get_tree().set_input_as_handled()
		set_process_input(false)
		$Panel/Info.text = ""
		
		if not event.is_action("ESC") and not event.is_action("ENTER"):
			var scancode = OS.get_scancode_string(event.scancode)
			
			for old_event in InputMap.get_action_list(button):
				InputMap.action_erase_event(button, old_event)
			
			InputMap.action_add_event(button, event)
			
			var name_key = OS.get_scancode_string(event.scancode)
			
			var config = ConfigFile.new()
			var dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
			if config.load(dir + "/" + "Raul mission.cfg") == OK:
				config.set_value("input", button, scancode)
				config.save(dir + "/" + "Raul mission.cfg")
				$Panel/Info.text = "SAVED"
				
				if button != "ESC" and button != "ENTER":
					match(button):
						"ATTACK" : $Panel/ATTACK.text = name_key
						"X" : $Panel/X.text = name_key
						"UP" : $Panel/UP.text = name_key
						"DOWN" : $Panel/DOWN.text = name_key
						"LEFT" : $Panel/LEFT.text = name_key
						"RIGHT" : $Panel/RIGHT.text = name_key


func _on_Button_pressed():
	$Panel.show()


func Save_Audio():
	var dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var config_file = ConfigFile.new()
	if config_file.load(dir + "/" + "Raul mission.cfg") != OK:
		config_file.set_value("MUSIC", "music_volume", 0)
		config_file.set_value("MUSIC", "sfx_volume", 0)
		config_file.save(dir + "/" + "Raul mission.cfg")
	else:
		config_file.set_value("MUSIC", "music_volume", Variables.volume_music)
		config_file.set_value("MUSIC", "sfx_volume", Variables.volume_sounds)
		config_file.save(dir + "/" + "Raul mission.cfg")

func _on_MUSIC_value_changed(value):
	Variables.volume_music = value
	$"../Music".volume_db = Variables.volume_music
	Save_Audio()


func _on_SFX_value_changed(value):
	Variables.volume_sounds = value
	AudioServer.set_bus_volume_db(1, Variables.volume_sounds)
	Save_Audio()

func SetSize(new):
	OS.window_size = Vector2(350*new, 255*new)
	var dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var config_file = ConfigFile.new()
	if config_file.load(dir + "/" + "Raul mission.cfg") == OK:
		config_file.set_value("RESOLUTION", "resolution", new)
		config_file.save(dir + "/" + "Raul mission.cfg")