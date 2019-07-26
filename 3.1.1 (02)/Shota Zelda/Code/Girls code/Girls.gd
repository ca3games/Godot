extends KinematicBody2D

onready var current = get_node("Candy")
enum girl {
	candy, aisha, anna, cadence, jasmene, leia, maria, mia
	}
onready var current_girl = girl.candy
var menu = false
var id = 0

var pos
var direction = 5
onready var speed = 0.5
var wait = false

func _process(delta):
	if !wait:
		Move($"../../Scripts/Variables".Player.pos, $"../../Scripts/Map".Map, $"../../Scripts/Map".mapsize)
	
		match(direction):
			4 : move_and_collide(Vector2(-speed, 0))
			6 : move_and_collide(Vector2(speed, 0))
			8 : move_and_collide(Vector2(0, -speed))
			2 : move_and_collide(Vector2(0, speed))


func Move(playerpos, map, mapsize):
	var left = costMove(pos.x-1, pos.y, playerpos, map, mapsize)
	var right = costMove(pos.x+1, pos.y, playerpos, map, mapsize)
	var top = costMove(pos.x, pos.y-1, playerpos, map, mapsize)
	var bottom = costMove(pos.x, pos.y+1, playerpos, map, mapsize)
	
	if left < right and left < top:
		direction = 4
	if right < left and right < top:
		direction = 6
	if top < right and top < bottom:
		direction = 8
	if bottom < right and bottom < top:
		direction = 2
		
	if left < 3 or right < 3 or top < 3 or bottom < 3:
		direction = 5
	

func costMove(x, y, playerpos, map, mapsize):
	if not IsValid(x, y, mapsize):
		return 9999
	else:
		if x > 1 and y > 1 and x < mapsize.x-2 and y < mapsize.y-2:
			if map[x][y].type != "empty":
				return 9999
			else:
				return abs(playerpos.x - x) + abs(playerpos.y - y)
		else:
			return abs(playerpos.x - x) + abs(playerpos.y - y)

func IsValid(x, y, mapsize):
	if x > 0 and y > 0 and x < mapsize.x and y < mapsize.y:
		return true
	return false

func _on_Area2D_area_entered(area):
	wait = true
	$Timer.start(1.5)
	yield($Timer, "timeout")
	wait = false


func _ready():
	$Sprite.hide()
	HideAll()
	SetGirlId()
	
func HideAll():
	$Candy.hide()
	$Aisha.hide()
	$Anna.hide()
	$Cadence.hide()
	$Jasmene.hide()
	$LEIA.hide()
	$Maria.hide()
	$Mia.hide()

func SetGirlId():
	match(id):
		0 : SetGirl("candy")
		1 : SetGirl("aisha")
		2 : SetGirl("anna")
		3 : SetGirl("cadence")
		4 : SetGirl("jasmene")
		5 : SetGirl("leia")
		6 : SetGirl("maria")
		7 : SetGirl("mia")

func SetGirl(name):
	match(name):
		"candy" :
			$Candy.show()
			current = $Candy
			current_girl = girl.candy
		"aisha" :
			$Aisha.show()
			current = $Aisha
			current_girl = girl.aisha
		"anna" :
			$Anna.show()
			current = $Anna
			current_girl = girl.anna
		"cadence" :
			$Cadence.show()
			current = $Cadence
			current_girl = girl.cadence
		"jasmene" :
			$Jasmene.show()
			current = $Jasmene
			current_girl = girl.jasmene
		"leia" :
			$LEIA.show()
			current = $LEIA
			current_girl = girl.leia
		"maria" :
			$Maria.show()
			current = $Maria
			current_girl = girl.maria
		"mia" :
			$Mia.show()
			current = $Mia
			current_girl = girl.mia