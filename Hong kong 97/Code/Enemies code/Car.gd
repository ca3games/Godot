extends Node2D

onready var score = rand_range(3, 20)
export(PackedScene) var Dead01

func _on_KinematicBody2D_body_entered(body):
	if body.is_in_group("PLAYER"):
		Variables.GameOver()
	
	if body.is_in_group("BULLET"):
		Variables.ChangeScore(score*3)
		var tmp = Dead01.instance()
		tmp.position = body.position
		$"../".add_child(tmp)
		body.queue_free()
		self.queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Car":
		self.queue_free()
