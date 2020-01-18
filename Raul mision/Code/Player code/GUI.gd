extends Node2D

var paused = false
var playtime

func _ready():
	Hit()
	$Timer.start(0.5)
	$Time.start(Variables.TimeLeft)


func _process(delta):
	if not get_tree().paused:
		$Timeleft.text = str(int($Time.time_left / 3))
	if $Time.time_left < 1 :
		Variables.GameOver()
	
	if Input.is_action_just_released("ESC") or Input.is_action_pressed("PAD_START"):
		if paused:
			$"../Music".play()
			$"../Music".seek(playtime)
			get_tree().paused = false
			paused = false
			$"../Paused".hide()
		else:
			get_tree().paused = true
			paused = true
			$"../Paused".show()
			playtime = $"../Music".get_playback_position()
			$"../Music".stop()

func SetGirl(id):
	match(id):
		0 : 
			$"list girls".region_rect = Rect2(0,0,32,32)
			$Girl.text = "CANDY"
		1 : 
			$"list girls".region_rect = Rect2(32*2,0,32,32)
			$Girl.text = "AISHA"
		2 : 
			$"list girls".region_rect = Rect2(32*3,0,32,32)
			$Girl.text = "ANNA"
		3 : 
			$"list girls".region_rect = Rect2(32*7,0,32,32)
			$Girl.text = "CADENCE"
		4 : 
			$"list girls".region_rect = Rect2(32*6,0,32,32)
			$Girl.text =  "JASMENE"
		5 : 
			$"list girls".region_rect = Rect2(32,0,32,32)
			$Girl.text = "LEIA"
		6 : 
			$"list girls".region_rect = Rect2(32*4,0,32,32)
			$Girl.text = "MARIA"
		7 : 
			$"list girls".region_rect = Rect2(32*5,0,32,32)
			$Girl.text = "MIA"


func _on_Timer_timeout():
	$Timer.start(1)
	if not paused:
		$Stamina.value += 10

func Hit():
	$HP.value = Variables.HP

func score(new):
	$Score.text = str(new)

func ShowKiss():
	$kiss.show()

func HideKiss():
	$kiss.hide()