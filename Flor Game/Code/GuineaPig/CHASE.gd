extends "res://Code/Player/BaseState.gd"

onready var targetangle = Vector3.ZERO
var target
var distance

func Update(delta):
	if is_instance_valid(target):
		targetangle = (target.global_transform.origin - FSM.Root.global_transform.origin).normalized()
		distance = target.global_transform.origin.distance_to(FSM.Root.global_transform.origin)
		if distance < 6:
			if target.attacked:
				FSM.Root.Hit(abs(target.HP))
			else:
				HitBall(target)
	else:
		target = GetRandomTarget()

func Physics(delta):
	var speed = targetangle * FSM.ChaseVel
	
	var vel = FSM.Root.move_and_slide(Vector3(speed.x, 0, speed.z))

func HitBall(body):
	if body == null:
		return
	body.GuineaHIT()
	body.last_hit = "GUINEA"
	body.falling = true
	var angle = targetangle * -1
	angle *= FSM.PushForce
	angle.y = FSM.PushY
	body.apply_impulse(Vector3.DOWN, angle)
	FSM.ChangeState("IDLE")
	$"../../ReturnToChase".start(rand_range(FSM.Root.MinReturnToChase, FSM.Root.MaxReturnToChase))

func GetRandomTarget():
	var i = FSM.Root.Enemies.get_child_count()
	if i == 0:
		return null
	else:
		return FSM.Root.Enemies.get_child(randi()%i)


func _on_ChangeTarget_timeout():
	target = GetRandomTarget()
	
	$"../../ChangeTarget".start(rand_range(3, 15))


func _on_ReturnToChase_timeout():
	if FSM.Root.HP > 0:
		print("RESET CHASE " + str(FSM.Root.HP) )
		FSM.ChangeState("CHASE")
