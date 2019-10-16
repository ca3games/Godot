extends KinematicBody

export(Color) var outline
export(bool) var P1
var speed = 0
var vel = 20

onready var ball = $"../Ball"
onready var bullet = preload("res://Scenes/Ship/Bullets/basic bullet kinematic.tscn")

func _ready():
	$ship.get_node("Cube/MeshInstance").get_surface_material(0).albedo_color = outline
	
	if P1:
		get_node("ship/Cube").get_surface_material(2).albedo_color = Color.greenyellow
		self.set_collision_layer(1)
		self.set_collision_mask(1)
	else:
		get_node("ship/Cube").get_surface_material(2).albedo_color = Color.orangered
		$Timer.start(0.4)
		self.set_collision_layer(2)
		self.set_collision_mask(2)


func _process(delta):
	speed = 0
	
	if P1:
		if Input.is_action_pressed("TOP"):
			speed = -vel
		if Input.is_action_pressed("DOWN"):
			speed = vel
		if Input.is_action_just_released("SPACEP1"):
			if $"../GUI".get_node("P1 Mana").value > 3:
				var b = bullet.instance()
				b.transform.origin = self.transform.origin
				b.P1 = true
				$"../P1bullets".add_child(b)
				$"../GUI".ChangeMana(true, -3)
	else:
		AI()

func AI():
	var ballpos = ball.transform.origin
	if transform.origin.z > ballpos.z + 1.2:
		speed = -vel
	elif transform.origin.z < ballpos.z - 1.2:
		speed = vel

func _physics_process(delta):
	var colision = move_and_collide(Vector3(0, 0, speed) * delta)
	
	if colision and colision.collider.is_in_group("Bullet"):
		if P1 and !colision.collider.P1:
			pass
		if !P1 and colision.collider.P1:
			$"../GUI".ChangeHP(false, -5)
			colision.collider.Delete()


func _on_Timer_timeout():
	$Timer.start(0.4)
	var distance = transform.origin.x - ball.transform.origin.x
	if distance < 8:
		if $"../GUI".get_node("P1 Mana").value > 3:
			var b = bullet.instance()
			b.transform.origin = self.transform.origin
			b.P1 = false
			$"../P2bullets".add_child(b)
			$"../GUI".ChangeMana(false, -3)
