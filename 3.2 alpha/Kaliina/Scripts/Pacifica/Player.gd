extends KinematicBody

onready var Venus = preload("res://Scenes/Tiles/Flytrap.tscn")

func SEED():
	var tmp = Venus.instance()
	var pos = self.global_transform.origin
	pos.z += 0.2
	tmp.global_transform.origin = pos
	get_parent().get_node("SEEDS").add_child(tmp)
