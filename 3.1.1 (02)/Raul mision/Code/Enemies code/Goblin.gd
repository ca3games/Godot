extends KinematicBody2D

var id
var pos
var dead_pos
var direction = 5
onready var speed = rand_range(0.5, 2)
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
		type.warrior : 
			$AnimatedSprite.frame = 0
			speed /= 2
		type.whitemage : 
			$AnimatedSprite.frame = 1
			$Heal.start(5)
		type.summoner : 
			$AnimatedSprite.frame = 2
			$ReviveTimer.start(5)
		type.archer : 
			var time = rand_range(3, 10)
			$Arrow.start(time)
			$AnimatedSprite.frame = 3

func _process(delta):
	if !wait:
		match(mytype):
			type.warrior : ChaseMove()
			type.summoner : AvoidMove()
			type.whitemage : AvoidMove()
			type.archer : AvoidMove()

func ChaseMove():
	Move($"../../Scripts/Variables".Player.pos, $"../../Scripts/Map".Map, $"../../Scripts/Map".mapsize)
	match(direction):
		4 : move_and_collide(Vector2(-speed, 0))
		6 : move_and_collide(Vector2(speed, 0))
		8 : move_and_collide(Vector2(0, -speed))
		2 : move_and_collide(Vector2(0, speed))

func AvoidMove():
	Avoid($"../../Scripts/Variables".Player.pos, $"../../Scripts/Map".Map, $"../../Scripts/Map".mapsize)
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

func Avoid(playerpos, map, mapsize):
	var left = costMove(pos.x-1, pos.y, playerpos, map, mapsize)
	var right = costMove(pos.x+1, pos.y, playerpos, map, mapsize)
	var top = costMove(pos.x, pos.y-1, playerpos, map, mapsize)
	var bottom = costMove(pos.x, pos.y+1, playerpos, map, mapsize)
	
	if left == 9999 :
		left = -999
	if right == 9999 :
		right = -999
	if top == 9999 :
		top = -999
	if bottom == 9999 :
		bottom = -999
	
	if left > right and left > top and left != 8888:
		direction = 4
	if right > left and right > top and right != 8888:
		direction = 6
	if top > right and top > bottom and top != 8888:
		direction = 8
	if bottom > right and bottom > top and bottom != 8888:
		direction = 2


func costMove(x, y, playerpos, map, mapsize):
	if not IsValid(x, y, mapsize):
		return 8888
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
		dead_pos = area.get_parent().pos
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
	
	$Color.interpolate_property($AnimatedSprite, "modulate", Color.white, Color8(10,12,150,255), 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Color.start()
	yield($Color, "tween_completed")
	$AnimatedSprite.modulate = Color.white
		
	var tmp = bullet.instance()
	tmp.position = self.position
	tmp.direction = $"../../Scripts/Variables".Player.Scene.position - self.position
	$"../".add_child(tmp)
	
	var time = rand_range(1, 5)
	$Arrow.start(time)

func BeingHealed():
	$Ring.modulate = Color8(16, 255, 205, 255)
	$Ring.show()
	$BeignHealed.start(1)
	yield($BeignHealed, "timeout")
	$Ring.hide()


func _on_Heal_timeout():
	$Ring.modulate = Color8(16, 255, 205, 255)
	$Ring.show()
	$HealTween.interpolate_property($AnimatedSprite, "modulate", Color.white, Color8(72, 255, 156, 255), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$HealTween.start()
	yield($HealTween, "tween_completed")
	$AnimatedSprite.modulate = Color.white
	
	$"../../Scripts/Variables".Heal()
	$Heal.start(5)
	$Ring.hide()


func _on_ReviveTimer_timeout():
	$Ring.modulate = Color8(255, 16, 16, 255)
	$Ring.show()
	$Revive.interpolate_property($AnimatedSprite, "modulate", Color.white, Color8(98, 46, 2, 255), 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Revive.start()
	yield($Revive, "tween_completed")
	$Ring.hide()
	$AnimatedSprite.modulate = Color.white
	
	$"../../Scripts/Variables".Revive()
	
	$ReviveTimer.start(5)
