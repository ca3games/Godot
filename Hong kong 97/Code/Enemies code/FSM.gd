extends Node2D

onready var current = $IDLE
export(NodePath) var RootPath
onready var Root = get_node(RootPath)

export(Vector2) var Direction
export(float) var Speed

func _process(delta):
	current.Update(delta)

func _physics_process(delta):
	current.Physics(delta)


func _on_VisibilityNotifier2D_screen_exited():
	Root.queue_free()
