extends Sprite

export(NodePath) var EnemiesPath
onready var Enemies = get_node(EnemiesPath)
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

export(Vector2) var myoffset
var target

func _ready():
	self.hide()
	yield(get_tree(), "idle_frame")
	target = GetNewTarget()

func ShowTarget():
	target = GetNewTarget()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	self.show()

func GetNewTarget():
	var targets = Enemies.get_children()
	var new_target = null
	var dist = 999999999
	
	for i in targets:
		var d = Player.global_position.distance_to(i.global_position)
		if d < dist:
			new_target = i
			dist = d
	return new_target

func _process(delta):
	if is_instance_valid(target):
		self.global_position = target.global_position + myoffset
	
	if Input.is_action_just_released("LOCK"):
		if not visible:
			ShowTarget()
		else:
			self.hide()
