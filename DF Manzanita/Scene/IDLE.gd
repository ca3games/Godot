extends Node


func Update(delta):
	var x = 0
	if Input.is_action_pressed("LEFT"):
		x = -1
	if Input.is_action_pressed("RIGHT"):
		x = 1
	
	if x != 0:
		$"../".ChangeState("WALK")
	
func Physics(delta):
	if $"../../AnimationPlayer".current_animation != "Idle":
		$"../../AnimationPlayer".play("Idle")
