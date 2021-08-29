extends Node2D

onready var current = $IDLE

onready var Direction = Vector2.RIGHT
export(float) var Speed
export(NodePath) var RootPath
onready var Root = get_node(RootPath)
export(NodePath) var AnimTreePath
onready var AnimTree = get_node(AnimTreePath)
export(NodePath) var SpritesPlayerPath
onready var SpritesPlayer = get_node(SpritesPlayerPath)
export(NodePath) var LeftRightPath
onready var LeftRight = get_node(LeftRightPath)
export(PackedScene) var BulletScene

func _process(delta):
	current.Update(delta)
	
	if Input.is_action_just_released("SPACE") and !Root.bullet:
		Root.bullet = true
		Root.get_node("OffsetBullets").start(0.5)
		Spawn()
		
func Spawn():
	var tmp = BulletScene.instance()
	tmp.position = Root.position
	Root.BulletManager.add_child(tmp)

func _physics_process(delta):
	current.Physics(delta)

func ChangeState(state):
	match(state):
		"IDLE" : current = $IDLE
		"WALK" : current = $WALK
