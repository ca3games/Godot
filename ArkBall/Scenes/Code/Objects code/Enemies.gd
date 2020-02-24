extends RigidBody2D

var stopped = false
var left = false
var speed = Vector2(0,0)
var vel = 50

var HP = 100
onready var Particle = preload("res://Scenes/Objects/Dead.tscn")
onready var Bullet = preload("res://Scenes/Objects/Bullet.tscn")

func _ready():
	randomize()
		
	var level = 1
	
	match(randi()%4):
		0:
			$AnimatedSprite.animation = "1"
			level = 1
		1:
			$AnimatedSprite.animation = "2"
			level = 2
		2:
			$AnimatedSprite.animation = "3"
			level = 3
		4:
			$AnimatedSprite.animation = "4"
			level = 4 
	
	level *= Variables.level
	
	match(randi()%4):
		0: 
			$AnimatedSprite.frame = 0
			HP = 20 * level
		1:
			$AnimatedSprite.frame = 1
			HP = 40 * level
		2:
			$AnimatedSprite.frame = 2
			HP = 60 * level
		3:
			$AnimatedSprite.frame = 3
			HP = 80 * level
	
	$TextureProgress.max_value = HP
	Hit(0)

func _physics_process(delta):
	
	if abs(self.linear_velocity.y) < 200 :
		self.linear_velocity = Vector2.ZERO
		stopped = true
	else:
		stopped = false
		
	if stopped:
		if left:
			speed.x = -vel
		else:
			speed.x = vel
		self.linear_velocity = speed
	
	$TextureProgress.rect_rotation = self.rotation_degrees * -1


func _on_Enemy_body_entered(body):
	if body.is_in_group("LEFT") or body.is_in_group("RIGHT") or body.is_in_group("ENEMY"):
		left = !left
	if body.is_in_group("BALL"):
		Hit(5)
		get_tree().get_root().get_node("Root").Bounce(5)
	
	if body.is_in_group("SUN"):
		Hit(1000)

func Hit(damage):
	HP -= damage
	$TextureProgress.value = HP
	
	if HP < 1:
		get_tree().get_root().get_node("Root").Crash()
		var tmp = Particle.instance()
		tmp.position = self.position
		$"../../Explosions".add_child(tmp)
		self.queue_free()
		


func _on_Timer_timeout():
	var time = rand_range(1, 3)
	$Timer.start(time)
	
	var tmp = Bullet.instance()
	tmp.position = self.position
	get_tree().get_root().get_node("Root/BULLETS").add_child(tmp)
