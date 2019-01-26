extends Node

onready var Nav = get_tree().get_root().get_node("Spatial/PathFinder/Navigation")
var path = []
var path_ind = 0
var time = true
onready var Root = $"../.."

var walking_speed = 0.5

func _Update():
	if time:
		_move(get_tree().get_root().get_node("Spatial/Player").transform.origin)
		$"../../Timer".start(0.2)
		time = false
	
	if Root.Far == false:
		Root._ChangeStatus("far")
	
	if Root.Near:
		Root._ChangeStatus("idle")
	
func _Physics():
	if path_ind < path.size():
		var move_vec = (path[path_ind] - $"../..".global_transform.origin)
		if move_vec.length() < 0.1:
			path_ind += 1
		else:
			$"../..".linear_velocity = move_vec.normalized() * walking_speed

func _move(target_pos):
	path = Nav.get_simple_path($"../..".global_transform.origin, target_pos)
	path_ind = 0

func _Timer_timeout():
	time = true
