extends Node

var midi = ""

func _ready():
	Load()
	

func save_config(path):
	var bongo_cat = ConfigFile.new()
	bongo_cat.set_value("Location", "midi", midi)
	bongo_cat.save(path)

func Save():
	var music = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	var save_path = music + "/" + "bongo_cat.cfg"
	save_config(save_path)

func Load():
	var bongo_cat = ConfigFile.new()
	var music = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	if bongo_cat.load(music + "/" + "bongo_cat.cfg") != OK:
		save_config(music + "/" + "bongo_cat.cfg")
		Load()
	else:
		midi = bongo_cat.get_value("Location", "midi", "")