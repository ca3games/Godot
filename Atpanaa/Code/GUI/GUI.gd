extends Node2D

var combo = 0
var guineacombo = 0
var florpoints = 0
var guineaspoints = 0
var cookiesleft = 100
var left = 100
var resetcookies = false

export(NodePath) var EnemiesManagerPath
onready var Enemies = get_node(EnemiesManagerPath)
export(NodePath) var CookiesManagerPath
onready var Cookies = get_node(CookiesManagerPath)

func _ready():
	$combolabel.hide()
	$HarvestedLabel.hide()
	$guineacombo.hide()
	yield(get_tree(), "idle_frame")
	UpdatePoints()

func _process(delta):
	left = Enemies.get_child_count()
	$LEFT/LEFT.text = str(left)
	
	cookiesleft = Cookies.get_child_count() - 1
	$COOKIES/LEFT.text = str(cookiesleft)
	
	if !resetcookies:
		CheckCookiesGameOver()

func CheckCookiesGameOver():
	if left <= 0:
		resetcookies = true
		Enemies.SpawnNewCookies()
		left = Enemies.get_child_count()
		$LEFT/LEFT.text = str(left)
		$ResetVeggies.start(0.5)
	
	if cookiesleft <= 0:
		Variables.GameOver()


func Hit():
	combo += 1
	$combolabel/COMBO.text = str(combo)
	$combolabel.show()
	$ComboTimer.start(3)

func GuineaHit(damage):
	guineacombo += 1
	$guineacombo/COMBO.text = str(guineacombo)
	$guineacombo.show()
	$GuineaComboTimer.start(2)

func _on_ComboTimer_timeout():
	combo = 0
	$combolabel.hide()
	
func KILL():
	$HarvestedLabel.show()
	$Harvested.start(2)
	florpoints += 1
	UpdatePoints()
	CheckCookiesGameOver()
	
func GUINEAKILL():
	guineaspoints += 1
	UpdatePoints()
	CheckCookiesGameOver()

func BOSSCOOKIE():
	CheckCookiesGameOver()

func _on_Harvested_timeout():
	$HarvestedLabel.hide()

func UpdatePoints():
	$guineapig/GuineaPoints.text = str(guineaspoints)
	$flor/FlorPoints.text = str(florpoints)
	
	var left = Enemies.get_child_count()
	$LEFT/LEFT.text = str(left)
	
	var cookies_left = Cookies.get_child_count()
	$COOKIES/LEFT.text = str(cookies_left)



func _on_GuineaComboTimer_timeout():
	$guineacombo.hide()
	guineacombo = 0


func _on_ResetVeggies_timeout():
	resetcookies = false
