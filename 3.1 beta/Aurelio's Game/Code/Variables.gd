extends Spatial

enum dificulty{
	easy, normal, hard
}

var Dificulty
var HP
var enemy_HP
var number_enemies
var bullet_speed
var extras
var score

func _ready():
	Dificulty = dificulty.normal
	SetDificulty()
	

func SetDificulty():
	score = 0
	match(Dificulty):
		dificulty.easy :
			bullet_speed = 0.5
			number_enemies = 30
			enemy_HP = 1
			HP = 100
			extras = 10
		dificulty.normal:
			bullet_speed = 0.8
			number_enemies = 50
			enemy_HP = 3
			HP = 50
			extras = 20
		dificulty.hard:
			bullet_speed = 1.2
			number_enemies = 80
			enemy_HP = 5
			HP = 25
			extras = 40

func GetDificulty():
	var d = 1
	match(Dificulty):
		dificulty.easy:
			d = 1
		dificulty.normal:
			d = 3
		dificulty.hard:
			d = 7
	return d

func ChangeScore(n):
	score += n
	get_tree().get_root().get_node("Spatial/Canvas/Score").text = str(score)
	
func GetTimeLeft():
	return get_tree().get_root().get_node("Spatial/TimeLeft").time_left
	
func GameOver():
	get_tree().change_scene("res://Scenes/GameScreen/Game_Over.tscn")
