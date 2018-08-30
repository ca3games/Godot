extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _changeColor(colour):
	if colour == 0:
		get_node("AnimatedSprite").play("corazon")
	if colour == 1:
		get_node("AnimatedSprite").play("diamante")
	if colour == 2:
		get_node("AnimatedSprite").play("pica")
	if colour == 3:
		get_node("AnimatedSprite").play("trebol")
	if colour == 5:
		get_node("AnimatedSprite").play("empty")

func _pressed():
	Values.rotate()
	get_node("/root/Node/Spawner")._rotate()
