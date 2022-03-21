extends Node2D

onready var current = $IDLE

export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)

onready var direction = Vector2.DOWN
onready var old_dir = Vector2.DOWN
export (float) var vel
export(NodePath) var LeftRightAnim
onready var LeftRight = get_node(LeftRightAnim)
onready var state_machine = $"../AnimationTree".get("parameters/playback")

export(int) var HP 

export(PackedScene) var Bullet

func _ready():
	yield(get_tree(), "idle_frame")
	if !Root.Town:
		Root.GUI.SetAmmoBasic(Variables.GetAmmo())

func _process(delta):
	current.CheckInput()
	current.Update(delta)

func _physics_process(delta):
	if old_dir.x < 0:
		LeftRight.play("RIGHT")
	else:
		LeftRight.play("LEFT")
	current.Physics(delta)

func ChangeState(state):
	match (state):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
		"KICK" : current = $KICK

