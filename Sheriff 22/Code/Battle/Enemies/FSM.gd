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

func _ready():
	randomize()
	vel = Root.speed

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(state):
	GetDirAngle()
	if Root.HP <= 0:
		state = "DEAD"
	match(state):
		"IDLE" : current = $IDLE
		"CHASE" : current = $CHASE
		"DEAD" : current = $DEAD


func _on_Return_to_Idle_timeout():
	direction = GetDirAngle()
	$"../Return to Idle".start(Root.idletimer)
	$"../Chase".start(Root.chasetimer)
	ChangeState("IDLE")


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
		if Root.BOSS:
			LeftRight.play("LEFTBOSS")
		else:
			LeftRight.play("LEFT")
	else:
		if Root.BOSS:
			LeftRight.play("RIGHTBOSS")
		else:
			LeftRight.play("RIGHT")
	
	return dir

func _on_Chase_timeout():
	ChangeState("CHASE")
