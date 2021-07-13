extends KinematicBody2D

export(NodePath) var EnemyManagerPath
onready var EnemyManager = get_node(EnemyManagerPath)

export(NodePath) var GUIManaPath
onready var GUIMana = get_node(GUIManaPath)

export(NodePath) var GUILifeBarPath
onready var GUIHP = get_node(GUILifeBarPath)

onready var attack = false

func _ready():
	$shield.hide()
	GUIMana.value = 0
	GUIHP.value = 100

func _on_X_button_up():
	$FSM.Direction.x *= -1


func _on_Y_button_up():
	$FSM.Direction.y *= -1


func _on_XY_button_up():
	$FSM.Direction.x *= -1
	$FSM.Direction.y *= -1


func _on_Shield_button_up():
	if GUIMana.value > 20:
		GUIMana.value -= 20
		$shield.show()
		$Attack.start(1)
		attack = true

func Hit():
	GUIHP.value -= 5
	if GUIHP.value < 1:
		Variables.GameOver()

func _on_Attack_timeout():
	$shield.hide()
	attack = false


func _on_Area2D_body_entered(body):
	
	GUIMana.value += 5
	
	if body.is_in_group("ENEMY"):
		if attack:
			body.Damage(GUIMana.value)
		else:
			body.Damage(5)
