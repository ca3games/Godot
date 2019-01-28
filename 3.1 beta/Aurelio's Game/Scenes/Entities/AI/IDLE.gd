extends Node

onready var Root = $"../../"
onready var Ani = $"../../AnimationPlayer"
onready var Player = get_tree().get_root().get_node("Spatial/Player")

func _ready():
	pass

func _Update():
	if Root.Near == false:
		Root._ChangeStatus("chase")
	
func _Physics():
	match (_Direction()):
		Vector2(-1, 0):
			if Ani.current_animation != "Side Left":
				Ani.play("Side Left")
		Vector2(1, 0):
			if Ani.current_animation != "Side Right":
				Ani.play("Side Right")
		Vector2(0, 1):
			if Ani.current_animation != "Front":
				Ani.play("Front")
		Vector2(0, -1):
			if Ani.current_animation != "Back":
				Ani.play("Back")
		Vector2(-1, -1):
			if Ani.current_animation != "Back Diagonal Left":
				Ani.play("Back Diagonal Left")
		Vector2(1, -1):
			if Ani.current_animation != "Back Diagonal Right":
				Ani.play("Back Diagonal Right")
		Vector2(1, 1):
			if Ani.current_animation != "Front Diagonal Right":
				Ani.play("Front Diagonal Right")
		Vector2(-1, 1):
			if Ani.current_animation != "Front Diagonal Left":
				Ani.play("Front Diagonal Left")
	
func _Direction():
	var direcion = Vector2(0,0)
	
	if Player.transform.origin.x < Root.get_global_transform().origin.x:
		direcion.x = -1
	if Player.transform.origin.x > Root.get_global_transform().origin.x:
		direcion.x = 1
	if Player.transform.origin.z < Root.get_global_transform().origin.z:
		direcion.y = 1
	if Player.transform.origin.z < Root.get_global_transform().origin.z:
		direcion.y = -1
	
	return direcion