extends RigidBody

var direction = 2
var speed = Vector2(0,0)
var vel = 0.5
var slow_walk = false

var HP
onready var HP_bar = get_tree().get_root().get_node("Spatial/Canvas/HP")

onready var current = $STATUS/IDLE

func _ready():
	HP = Variables.HP
	HP_bar.max_value = HP
	HP_bar.value = HP

func _input(event):
	current._MyInput()

func _process(delta):
	_input(delta)
	current._Animation()
	
func _physics_process(delta):
	current._Physics()
	
func _ChangeStatus(state):
	match(state):
		"move" : current = $STATUS/MOVE
		"idle" : current = $STATUS/IDLE
		"shoot" : current = $STATUS/SHOOT
		"melee" : current = $STATUS/KNIFE

func _Hit(hit):
	HP += hit
	HP_bar.value = HP
	
	get_tree().get_root().get_node("Spatial/Canvas/Mana").value -= 3
	
	if HP < 1:
		get_tree().get_root().get_node("Spatial").GameOver()

func _Slow():
	$SlowWalk.start(3)
	slow_walk = true
	$AnimatedSprite3D.material_override.set("albedo_color", Color8(100,100,255,255))

func _on_SlowWalk_timeout():
	slow_walk = false
	$AnimatedSprite3D.material_override.set("albedo_color", Color8(255,255,255,255))
