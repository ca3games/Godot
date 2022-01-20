extends Camera

export(float) var Angle
export(float) var YHeight
export(float) var Yground
export(float) var speed
export(Vector2) var StartOffset
export(Vector2) var ZMargin
export(float) var XMargin
export(NodePath) var ObjectFollowPath
onready var ObjectFollow = get_node(ObjectFollowPath)

func _ready():
	self.global_transform.origin = ObjectFollow.global_transform.origin + Vector3(StartOffset.x, 0, StartOffset.y)
	self.global_transform.origin.y = YHeight
	rotation_degrees.x = -Angle
	$Childs.rotation_degrees.x += Angle
	$Childs/PlayerPosArea.global_transform.origin = Vector3(ObjectFollow.global_transform.origin.x, Yground, ObjectFollow.global_transform.origin.z)
	
func _process(delta):
	var normal = ObjectFollow.global_transform.origin - $Childs/PlayerPosArea.global_transform.origin
	var s = delta * speed * 0.8
	if abs(normal.x) > XMargin:
		if normal.x < 0:
			self.global_transform.origin.x -= s
		elif normal.x > 0:
			self.global_transform.origin.x += s
	if normal.z > ZMargin.x:
		self.global_transform.origin.z += s
	if normal.z < ZMargin.y:
		self.global_transform.origin.z -= s
