extends Node2D

var game_over

func _ready():
	if $score != null:
		$score.text = str(Variables.score)
		game_over = true
	else:
		game_over = false
	
	get_tree().paused = false


func _process(delta):
	if Input.is_action_just_released("ENTER"):
		print("ENTER")
		if game_over:
			Variables.Back()
		else:
			$Shader.get_node("Timer").start(1.1)
			$Shader.Start()
			yield($Shader.get_node("Timer"), "timeout")
			Variables.StartGame()

