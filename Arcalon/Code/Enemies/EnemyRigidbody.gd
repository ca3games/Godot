extends RigidBody2D

onready var walk = true
onready var FSM = $"FSM"

onready var HP = 10
onready var MaxHP = 50

onready var Enemies = get_tree().get_root().get_node("Battle/Enemies")

var BulletsManagerPath
var BulletsManager

export(PackedScene) var DeadSpark

func _ready():
	
	yield(get_tree(), "idle_frame")
	
	$HP/HP.max_value = MaxHP
	HP = MaxHP
	ChangeHP(HP)
	
	BulletsManager = get_node(BulletsManagerPath)

func _integrate_forces(state):
	if walk:
		var rb = state.get_transform()
		rb.origin.x += FSM.Direction.x * FSM.speed
		state.set_transform(rb)

func _process(delta):
	$HP.global_rotation = 0

func _on_EnemyBase_body_entered(body):
	if body.is_in_group("BALL"):
		body.HitSound()
		body.Bounce()
		walk = false
		FSM.ChangeState("IDLE")
		$"INERTIA".start(3)
		if body.attack:
			Damage(body.GUIMana.value)
		else:
			Damage(5)
		
	
	if body.is_in_group("H_WALL"):
		FSM.Direction.x *= -1
		JumpToCenter(20)
	
	if body.is_in_group("ENEMY"):
		FSM.Direction.x *= -1
	
	if body.is_in_group("SUN"):
		print("SUN PREVIOUS")
		Variables.PlaySUN()
		Damage(500)

func _on_INERTIA_timeout():
	walk = true
	FSM.ChangeState("WALK")


func _on_RESET_timeout():
	JumpToCenter(80)
	var time = randi()% 8
	$"RESET".start(time)

func JumpToCenter(r):
	var an_n = Vector2.ZERO
	if self.position.x < 540:
		an_n.x = 1
	else:
		an_n.x = -1
	if self.position.y < 960:
		an_n.y = 1
	else:
		an_n.y = -1
	var force = randi()% r
	self.apply_impulse(Vector2(10, 10), an_n * force)

func Damage(dg):
	HP -= dg
	Variables.Add_score(rand_range(3, MaxHP/3))
	$HP/HP.value = HP
	if HP <= 0:
		var tmp = DeadSpark.instance()
		tmp.position = FSM.Root.position
		FSM.Root.get_parent().add_child(tmp)
		Variables.Add_score(rand_range(3, MaxHP))
		self.queue_free()

func ChangeHP(damage):
	HP = damage
	$HP/HP.value = HP

