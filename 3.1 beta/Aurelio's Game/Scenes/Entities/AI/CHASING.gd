extends Node

onready var Nav = get_tree().get_root().get_node("Spatial/PathFinder/Navigation")
var path = []
var path_ind = 0
var time = true
onready var Root = $"../.."
onready var Ani = $"../../AnimationPlayer"
var Aurelio

var walking_speed = 0.5

func _Update():
	if time:
		_move(get_tree().get_root().get_node("Spatial/Player").transform.origin)
		$"../../Timer".start(0.8)
		time = false
	
	if Root.Far == false:
		Root._ChangeStatus("far")
	
	if Root.Near:
		Root._ChangeStatus("idle")
		
	if Root.time_shooting:
		$"../../Shoot".start(rand_range(1, 3))
		Root.time_shooting = false
		Root._ChangeStatus("shoot")
	
func _Physics():
	if path_ind < path.size():
		var pos = $"../..".global_transform.origin
		var move_vec = (path[path_ind] - pos)
		if move_vec.length() < 0.1:
			path_ind += 1
			var direction = 1
			if path[path_ind].z < Root.global_transform.origin.z:
				if  path[path_ind].x < Root.global_transform.origin.x:
					direction = 7
				else:
					direction = 9
			else:	
				if  path[path_ind].x < Root.global_transform.origin.x:
					direction = 1
				else:
					direction = 3
			match(direction):
				1:
					if Ani.current_animation != "Front Dia Left Walking":
						Ani.play("Front Dia Left Walking")
				3:
					if Ani.current_animation != "Front Dia Right Walking":
						Ani.play("Front Dia Right Walking")
				7:
					if Ani.current_animation != "Front Dia Right Walking":
						Ani.play("Back Dia Left Walking")
				9:
					if Ani.current_animation != "Front Dia Right Walking":
						Ani.play("Back Dia Right Walking")

		else:
			var tmp = move_vec.normalized() * walking_speed
			$"../..".linear_velocity = tmp

func _move(target_pos):
	Aurelio = target_pos
	path = Nav.get_simple_path($"../..".global_transform.origin, Aurelio)
	path_ind = 0

func _Timer_timeout():
	time = true
