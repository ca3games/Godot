extends Camera

onready var T = $TweenCamera
onready var Player = get_tree().get_root().get_node("Spatial/Player")
onready var Pos = $Position3D
var dist = 0.5
var interpolate = true
var out = false

func _ready():
	pass 

func _process(delta):
	
	if interpolate and out:
		_moveCamera()
		interpolate = false

func _OUT(body):
	print ("BODY OUT")
	if body.is_in_group("Player"):
		print ("PLAYER OUT")
		out = true

func _completed(object, key):
	interpolate = true

func _moveCamera():
	var direction = Vector2(0,0)
	if Player.transform.origin.z >  Pos.get_global_transform().origin.z + (dist):
		direction.y = dist
	elif Player.transform.origin.z <  Pos.get_global_transform().origin.z - (dist):
		direction.y = -dist
	if Player.transform.origin.x > Pos.get_global_transform().origin.x + (dist):
		direction.x = dist
	elif Player.transform.origin.x < Pos.get_global_transform().origin.x - (dist):
		direction.x = -dist
	
	var new_dist = self.transform.origin + Vector3(direction.x, 0, direction.y)
	
	T.interpolate_property(self, "translation", self.transform.origin, new_dist,
		1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if out :
		T.start()

func _body_entered(body):
	print("BODY ENTERED")
	if body.is_in_group("Player"):
		print ("BODY IS PLAYER")
		out = false
