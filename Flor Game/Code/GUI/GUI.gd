extends Node2D

var combo = 0
var guineacombo = 0
var florpoints = 0
var guineaspoints = 0

export(NodePath) var EnemiesManagerPath
onready var Enemies = get_node(EnemiesManagerPath)

func _ready():
	$combolabel.hide()
	$HarvestedLabel.hide()
	$guineacombo.hide()
	UpdatePoints()

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
	$HPBAR.value += 3

func GuineaHit():
	guineacombo += 1
	$guineacombo/COMBO.text = str(guineacombo)
	$guineacombo.show()
	$GuineaComboTimer.start(2)
	$HPBAR.value -= 3

func _on_ComboTimer_timeout():
	combo = 0
	$combolabel.hide()
	
func KILL():
	$HarvestedLabel.show()
	$Harvested.start(2)
	florpoints += 1
	UpdatePoints()
	
func GUINEAKILL():
	guineaspoints += 1
	UpdatePoints()

func _on_Harvested_timeout():
	$HarvestedLabel.hide()

func UpdatePoints():
	$guineapig/GuineaPoints.text = str(guineaspoints)
	$flor/FlorPoints.text = str(florpoints)


func _on_GuineaComboTimer_timeout():
	$guineacombo.hide()
	guineacombo = 0


func _on_HPBAR_value_changed(value):
	if $HPBAR.value <= $HPBAR.min_value:
		Variables.GameOver()
	
	if $HPBAR.value >= $HPBAR.max_value:
		Variables.GameOver()
