extends KinematicBody2D

var HP = 10

export (float) var magnitude
var angle = 0
var angley = 0
export (int) var frequency
export(float) var magnitudeY

export(PackedScene) var dead

func _ready():
	pass

func _physics_process(delta):
	angle += delta
	var dir = Vector2.ZERO
	dir.x = cos(angle) * magnitude
	angley += delta * frequency
	
	dir.y = sin(angley) * magnitudeY
	
	var colision = move_and_collide(dir)
	
	if colision:
		if colision.collider.is_in_group("PLAYER"):
			Variables.GameOver()
		if colision.collider.is_in_group("BULLET"):
			colision.collider.queue_free()
			HP -= 1

func Hit():
	HP -= 1

func Die():
	var tmp = dead.instance()
	tmp.position = position
	get_parent().add_child(tmp)
	self.queue_free()
