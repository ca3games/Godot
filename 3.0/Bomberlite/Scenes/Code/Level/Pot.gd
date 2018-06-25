extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _Player(body):
	if body.is_in_group("Player"):
		get_tree().get_root().get_node("Spatial/GrabPot").show()


func _Potexit(body):
	if body.is_in_group("Player"):
		get_tree().get_root().get_node("Spatial/GrabPot").hide()
