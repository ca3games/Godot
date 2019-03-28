extends RigidBody

var current 
var Near = false
var Far = false
var time_shooting = false
var HP

var damage

onready var camera = get_tree().get_root().get_node("Spatial/Camera")
onready var joint = preload("res://Scenes/Particles/Joint.tscn")

var color_jacket = {
	"red" : Color8(255,0,0,255),
	"blue" : Color8(5,3,215,255),
	"brown" : Color8(99,49,0,255),
	"orange" : Color8(249,135,3,255),
	"green" : Color8(18,167,1,255),
	"normal" : Color8(0,0,0,255)
	}

var mamerto_color
enum color_type {
	normal, red, blue, brown, orange, green, random
}

export (color_type) var mamerto_type = color_type.normal

func _ready():
	_ChangeStatus("idle")
	if mamerto_type != color_type.random:
		mamerto_color = getColor(mamerto_type)
	else:
		mamerto_color = random_color()
	$AnimatedSprite3D.ChangeColor(mamerto_color)
	GetDamage(mamerto_type)
	
	HP = Variables.enemy_HP
	$GUI/TextureProgress.max_value = HP
	$GUI/TextureProgress.value = HP
	

func GetDamage(t):
	match(t):
		color_type.red:
			damage = 15
		color_type.blue:
			damage = 0
		color_type.brown:
			damage = 2
		color_type.orange:
			damage = 1
		color_type.green:
			damage = -1
		color_type.normal:
			damage = 5

func random_color():
	var color = int (rand_range(0, 5) + 1)
	var mamer_color
	var new_type
	match(color):
		1 : 
			mamer_color = color_jacket["red"]
			new_type = color_type.red
		2 : 
			mamer_color = color_jacket["blue"]
			new_type = color_type.blue
		3 : 
			mamer_color = color_jacket["brown"]
			new_type = color_type.brown
		4 : 
			mamer_color = color_jacket["orange"]
			new_type = color_type.orange
		5 : 
			mamer_color = color_jacket["green"]
			new_type = color_type.green
	mamerto_type = new_type
	return mamer_color

func getColor(c):
	var mamer_color
	match (c):
		color_type.red:
			mamer_color = color_jacket["red"]
		color_type.blue:
			mamer_color = color_jacket["red"]
		color_type.brown:
			mamer_color = color_jacket["brown"]
		color_type.orange:
			mamer_color = color_jacket["orange"]
		color_type.green:
			mamer_color = color_jacket["green"]
		color_type.normal:
			mamer_color = color_jacket["normal"]
	return mamer_color
	
func _process(delta):
	if current != null:
		current._Update()
		var pos = camera.unproject_position(self.global_transform.origin)
		$GUI/TextureProgress.set("rect_position", pos)
	
func _physics_process(delta):
	if current != null:
		current._Physics()
	
func _ChangeStatus(new_status):
	match(new_status):
		"idle" : current = $STATES/IDLE
		"chase" : current = $STATES/CHASING
		"far" : current = $STATES/FAR
		"dead" : current = $STATES/DEAD
		"shoot" : current = $STATES/SHOOT


func _Near_entered(body):
	if body.is_in_group("Player"):
		Near = true

func _Near_exited(body):
	if body.is_in_group("Player"):
		Near = false


func _Far_entered(body):
	if body.is_in_group("Player"):
		Far = true

func _Far_exited(body):
	if body.is_in_group("Player"):
		Far = false

func _PistolHit(hit):
	var mana = get_tree().get_root().get_node("Spatial/Canvas/Mana").value
	HP -= hit + (mana / 3)
	Variables.ChangeScore(int(hit * Variables.GetTimeLeft()))
	$GUI/TextureProgress.value = HP
	get_tree().get_root().get_node("Spatial/Canvas/Mana").value += 1
	if HP < 1:
		Variables.ChangeScore(int(Variables.GetDificulty() * Variables.GetTimeLeft()))
		var c = int(rand_range(0, 5) + 1)
		if c == 2:
			var tmp = joint.instance()
			tmp.global_transform.origin = global_transform.origin
			get_tree().get_root().get_node("Spatial").add_child(tmp)
		_ChangeStatus("dead")
	
func _Delete():
	self.queue_free()

func _on_Shoot_timeout():
	time_shooting = true
