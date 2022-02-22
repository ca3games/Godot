extends Node2D

export(float) var tick
export(PackedScene) var Note
export(float) var YSize

func _ready():
	pass

func AddNote(key):
	print("****************")
	print("add note ", key)
	var tmp = Note.instance()
	print(tmp)
	print("tmp added")
	tmp.position = Vector2(tick, YSize * (key%12))
	print(tmp.position)
	$Notes.add_child(tmp)
