extends Node2D

var combo = 0

export(NodePath) var EnemiesManagerPath
onready var Enemies = get_node(EnemiesManagerPath)

func _ready():
	$combolabel.hide()
	$HarvestedLabel.hide()

func _process(delta):
	var left = Enemies.get_child_count()
	$LEFT/LEFT.text = str(left)
	
	if left < 1:
		Variables.GameOver()

func Hit():
	combo += 1
	$combolabel/COMBO.text = str(combo)
	$combolabel.show()
	$ComboTimer.start(3)


func _on_ComboTimer_timeout():
	combo = 0
	$combolabel.hide()
	
func KILL():
	$HarvestedLabel.show()
	$Harvested.start(2)

func _on_Harvested_timeout():
	$HarvestedLabel.hide()
