extends Node2D

export (NodePath) var RootPath
onready var Root = get_node(RootPath)
export(float) var vel
onready var state_machine = $"../AnimTree".get("parameters/playback")

export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)
export(NodePath) var LeftRightAnim
onready var LeftRight = get_node(LeftRightAnim)

onready var current = $IDLE
var direction = Vector2.DOWN

export(int) var HP 

func _ready():
	randomize()
	$"../Return to Idle".start(rand_range(1, 3))
	vel = Root.level * 15 + 20

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(state):
	match(state):
		"IDLE" : current = $IDLE
		"CHASE" : current = $CHASE
		"DEAD" : current = $DEAD


func _on_Return_to_Idle_timeout():
	direction = GetDirAngle()
	$"../Return to Idle".start(IdleTimerID())
	$"../Chase".start(ChaseTimerID()+1)
	ChangeState("IDLE")

func IdleTimerID():
	if Root.level < 3:
		return rand_range(2, 4)
	elif Root.level > 7:
		return rand_range(8, 12)
	return rand_range(6, 8)

func ChaseTimerID():
	if Root.level < 3:
		return rand_range(4, 5)
	elif Root.level > 7:
		return rand_range(1, 2)
	return rand_range(2, 3)


func GetDirAngle():
	var playerpos = Root.get_parent().Player.global_position
	var angle = (playerpos - Root.global_position).normalized()
	
	var dir = Vector2.ZERO
	
	if angle.x < 0.2:
		dir.x = -1
	if angle.x > 0.2:
		dir.x = 1
	if angle.y < 0.2:
		dir.y = 1
	if angle.y > 0.2:
		dir.y = -1
	
	if dir.x == -1:
		LeftRight.play("LEFT")
	else:
		LeftRight.play("RIGHT")
	
	return dir

func _on_Chase_timeout():
	ChangeState("CHASE")
