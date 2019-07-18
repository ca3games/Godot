extends KinematicBody2D

var mouseover = false
var selected = false
const MOVEMENT_SPEED = 96
const POINT_RADIUS = 5
var path

func _ready():
	$Select.hide()
	self.connect("RIGHT_CLICK", self, "_calculate_new_path")

func _process(delta):
	if Input.is_action_just_released("CLICK"):
		if selected:
			path = null
		if mouseover:
			$Select.show()
			selected = true
		else:
			$Select.hide()
			selected = false
	
	if selected:
		if Input.is_action_just_released("RIGTH_CLICK"):
			var tmp = $"../../Scripts/PathFinding".Get_Path(position, $"../../Flag".position)
			if tmp:
				tmp.remove(0)
			path = tmp
		
	if path:
		var target = path[0]
		
		var direction = (target - position).normalized()
		
		position += direction * MOVEMENT_SPEED * delta
		
		if position.distance_to(target) < POINT_RADIUS:
			path.remove(0)
			
			if path.size() == 0:
				path = null
	

func _on_SelectArea_mouse_entered():
	mouseover = true


func _on_SelectArea_mouse_exited():
	mouseover = false