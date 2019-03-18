extends Spatial

onready var entrada = preload("res://Scenes/Level/Level01.tscn")

onready var mamerto = preload("res://Scenes/Entities/Mamerto 01.tscn")

enum nivel {
	Entrada
	}

export (nivel) var Level

func _ready():
	var tmp
	
	match (Level):
		nivel.Entrada:
			tmp = entrada.instance()
	
	tmp.global_translate(Vector3(0,0,-8))
	add_child(tmp)
	
	var TopLeft = $TOPLEFT.global_transform.origin
	var BottomRight = $BOTTOMRIGHT.global_transform.origin
	
	for i in range(Variables.number_enemies):
		var mamer = mamerto.instance()
		var pos = Vector3(0,0.1,0)
		pos.x = rand_range(TopLeft.x, BottomRight.x)
		pos.z = rand_range(TopLeft.z, BottomRight.z)
		mamer.global_transform.origin = pos
		mamer.mamerto_type = mamer.color_type.normal
		add_child(mamer)
	
	for i in range(Variables.extras):
		var mamer = mamerto.instance()
		var pos = Vector3(0,0.1,0)
		pos.x = rand_range(TopLeft.x, BottomRight.x)
		pos.z = rand_range(TopLeft.z, BottomRight.z)
		mamer.global_transform.origin = pos
		mamer.mamerto_type = mamer.color_type.random
		add_child(mamer)
		
	var count = get_tree().get_nodes_in_group("Enemies").size()
	$Canvas/EnemiesLeftLabel.text = str(count)
	$TimeLeft._SetClock(count)
	Variables.score = 0
	Variables.ChangeScore(0)

func _SetEnemyCount():
	var count = get_tree().get_nodes_in_group("Enemies").size() - 1
	if count < 1:
		Variables.GameOver()
	$Canvas/EnemiesLeftLabel.text = str(count)
	
func GameOver():
	Variables.GameOver()
