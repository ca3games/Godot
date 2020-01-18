extends RigidBody2D

var speed = Vector2(0,0)

func _ready():
	set_fixed_process(true)
	speed = self.get_pos() - get_node("/root/Node/YSort/Negrito").get_pos()
	speed = speed.normalized()
	speed *= -1
	speed *= 50

func _fixed_process(delta):
	set_linear_velocity(speed)


func _body_enter( body ):
	if body.is_in_group("Wall"):
		self.queue_free()
	
	if body.is_in_group("Player"):
		var HP = get_node("/root/Node/GUI/HP/").get_value()
		HP -= 10
		get_node("/root/Node/GUI/HP/").set_value(HP)
		if HP < 1:
			if Score.score > Score.last_score:
				Score.last_score = Score.score
			Score.score = 0
			get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		self.queue_free()
