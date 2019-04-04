extends Node2D

onready var Enemy01 = preload("res://Scenes/Enemy01.tscn")

func _ready():
	for i in range(Variables.level + 1):
		var tmp = Enemy01.instance()
		var x = rand_range($TOPLEFT.position.x, $BOTTOMRIGHT.position.x)
		var y = rand_range($TOPLEFT.position.y, $BOTTOMRIGHT.position.y)
		tmp.position = Vector2(x,y)
		$Enemies.add_child(tmp)
		
		Variables.SetLeftText(Variables.level + 1)
		$"GUI/Level".text = str(Variables.level + 1)
		
		find_node("Score").text = str(Variables.score)
		get_tree().paused = true
		$Transition._ToEnter()

func _process(delta):
	Variables.SetTimeLabel()
	
func _ScoreTweenCompleted(object, key):
	get_tree().get_root().get_node("Root/GUI/Score").set("custom_colors/font_color", Color8(202,255,249))


func _TimeLeft_timeout():
	Variables.TimeOver()
