extends RigidBody2D

var mana = false

func _ready():
	get_node("AnimationPlayer").play("IDLE")
	set_process(true)
	get_node("Fuck").hide()

func _process(delta):
	if get_global_pos().distance_to(get_node("/root/Node/YSort/Negrito").get_global_pos()) < 50:
		get_node("Fuck").show()
		if Input.is_action_pressed("FUCK"):
			if !get_node("/root/Node/Video").is_visible():
				get_node("/root/Node/Video").show()
				if !get_node("/root/Node/Video/VideoPlayer").is_playing():
					var tmp = get_node("/root/Node/GUI/Mana").get_value()
					if !tmp < 20:
						if !mana:
							get_node("/root/Node/Video/VideoPlayer").play()
							get_node("/root/Node/Music/").set_volume(0)
							var hp = get_node("/root/Node/GUI/HP").get_value()
							hp += 35
							get_node("/root/Node/GUI/HP").set_value(hp)
							tmp -= 20
							get_node("/root/Node/GUI/Mana").set_value(tmp)
					else:
						mana = true
						get_node("/root/Node/YSort/Pony/Fuck").set_text("Cansada")
	else:
		get_node("Fuck").hide()
	
	if get_node("/root/Node/Video").is_visible():
		if !get_node("/root/Node/Video/VideoPlayer").is_playing():
			get_node("/root/Node/Video").hide()
			get_node("/root/Node/Music/").set_volume(0.7)