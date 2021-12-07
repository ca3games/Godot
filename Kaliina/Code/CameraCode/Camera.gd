extends Camera

export(float) var Speed
export(float) var xoffset
export(Vector2) var zoffset
var dir = Vector2.ZERO
onready var followX = false
onready var followZ = false
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)

func _process(delta):
	followX = false
	followZ = false
	
	var x = Player.global_transform.origin.x - $Offset.global_transform.origin.x
	var z = Player.global_transform.origin.z - $Offset.global_transform.origin.z
	
	if abs(x) > xoffset:
		followX = true
	
	if z < zoffset.x: 
		followZ = true
	if z > zoffset.y:
		followZ = true
	
	if followX:
		var s = x * delta * Speed
		s *= 0.5
		self.translation.x += s
		
	if followZ:
		var s = z * delta * Speed
		if z < zoffset.x:
			s *= 0.5
		self.translation.z += s
