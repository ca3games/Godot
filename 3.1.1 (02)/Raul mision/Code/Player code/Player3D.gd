extends KinematicBody2D

var idle = true

func _ready():
	get_tree().paused = false

func _process(delta):
	
	var stamina = $"../../GUI".get_node("Stamina").value
	if Input.is_action_pressed("ATTACK") and idle and stamina >= 10:
		idle = false
		$"../../GUI".get_node("Stamina").value -= 10
		match($STATES.old_direction):
			Vector2(1, 0): $Images/SlashAni.play("Side")
			Vector2(-1, 0): $Images/SlashAni.play("Side")
			Vector2(0, 1): $Images/SlashAni.play("Front")
			Vector2(0, -1): $Images/SlashAni.play("Back")
			Vector2(1, 1): $Images/SlashAni.play("Front D")
			Vector2(-1, 1): $Images/SlashAni.play("Front D")
			Vector2(1, -1): $Images/SlashAni.play("Back D")
			Vector2(-1, -1): $Images/SlashAni.play("Back D")

func _on_SlashAni_animation_finished(anim_name):
	idle = true
	
func Hit():
	$Images/Hit.play("Hit")
	$"../../ScreenShake".Start(3)
