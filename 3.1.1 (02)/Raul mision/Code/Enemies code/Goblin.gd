extends KinematicBody2D

var id
var pos
var direction = 5
onready var speed = rand_range(0.5, 4)
var wait = false
onready var bullet = preload("res://Scenes/Enemies/Bullets.tscn")

enum type {
	warrior, summoner, whitemage, archer
	}
	
var mytype

func SetType(new):
	match(new):
		"warrior" : mytype = type.warrior
		"summoner" : mytype = type.summoner
		"white" : mytype = type.whitemage
		"archer" : mytype = type.archer

func _ready():
	match(mytype):
		type.warrior : $AnimatedSprite.frame = 0
		type.whitemage : $AnimatedSprite.frame = 1
		type.summoner : $AnimatedSprite.frame = 2
		type.archer : 
			var time = rand_range(3, 10)
			$Arrow.start(time)
			$AnimatedSprite.frame = 3

func _process(delta):
	if !wait:
		match(mytype):
			type.warrior : WarriorMove()
			type.summoner : pass
			type.whitemage : pass
			type.archer : pass

func WarriorMove():
	Move($"../../Scripts/Variables".Player.pos, $"../../Scripts/Map".Map, $"../../Scripts/Map".mapsize)
	match(direction):
		4 : move_and_collide(Vector2(-speed, 0))
		6 : move_and_collide(Vector2(speed, 0))
		8 : move_and_collide(Vector2(0, -speed))
		2 : move_and_collide(Vector2(0, speed))

func ChangeHP(new):
	$TextureProgress.value = new

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
	if area.is_in_group("Tile"):
		wait = true
		$Timer.start(speed)
		yield($Timer, "timeout")
		wait = false

	if area.is_in_group("Attack"):
		$"../../ScreenShake".Start(0.8)
		$"../../Scripts/Variables".DamageEnemy(id)
		$Hit.interpolate_property(self, "position", Vector2(position.x, position.y - 8), position, 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		$Hit.start()


func _on_aTTACK_body_entered(body):
	if body.is_in_group("Hero"):
		$"../../Scripts/Variables".Hit(-30)
		body.Hit()


func _on_Arrow_timeout():
	var tmp = bullet.instance()
	tmp.position = self.position
	tmp.direction = $"../../Scripts/Variables".Player.Scene.position - self.position
	$"../".add_child(tmp)
	
	var time = rand_range(2.5, 10.0)
	$Arrow.start(time)
