extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("AnimationPlayer").play("IDLE")
	pass
