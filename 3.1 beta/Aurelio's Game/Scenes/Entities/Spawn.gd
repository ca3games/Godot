extends Node

onready var Mamerto01 = preload("res://Scenes/Entities/Mamerto 01.tscn")
onready var TopLeft = $"../Corners/TopLeft"
onready var BottomRight = $"../Corners/BottomRight"

func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_tree().get_nodes_in_group("Enemies").size() < 3 :
		var mamer = Mamerto01.instance()
		var pos = Vector3(0,0,0)
		pos.x = rand_range(TopLeft.transform.origin.x, BottomRight.transform.origin.x)
		pos.z = rand_range(TopLeft.transform.origin.z, BottomRight.transform.origin.z)
		pos.y = 0.1
		mamer.transform.origin = pos
		add_child(mamer)