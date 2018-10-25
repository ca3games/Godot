extends Spatial

onready var grass = preload("res://Scenes/ascii/Grass.tscn")
onready var ground = preload("res://Scenes/Tiles/grass_ground.tscn")

func _red():
	$AnimationPlayer.play("red_step")
	
	
func _white():
	$AnimationPlayer.play("white_step")
	
func _addnode(body):
	add_child(body)
	
func _addgrass():
	var t = grass.instance()
	add_child(t)
	var g = ground.instance()
	add_child(g)