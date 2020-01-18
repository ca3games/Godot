extends Spatial

onready var Pacifica = get_tree().get_root().get_node("Root/Pacifica")
var angle
var angle_normalized
var direction
onready var Root = $"../.."
onready var AniSprite = $"../../AnimatedSprite3D"
onready var Ani = $"../../AnimationPlayer"

func Update(delta):
	angle = Pacifica.global_transform.origin - Root.global_transform.origin
	angle_normalized = angle.normalized()
	
	direction = Vector2(0,0)
	if angle_normalized.x < -0.5:
		direction.x = -1
	elif angle_normalized.x > 0.5:
		direction.x = 1
	
	if angle_normalized.z < -0.5:
		direction.y = -1
	elif angle_normalized.z > 0.5:
		direction.y = 1
	
	$"../".Speed = direction * $"../".vel
	
func Physics(delta):
	if Ani.current_animation != "Walk" and Ani.is_playing() == false:
		Ani.play("Walk")
	
	Root.linear_velocity = Vector3($"../".Speed.x, 0, $"../".Speed.y)
	
	match (direction):
		Vector2(-1,0):
			AniSprite.frame = 6
		Vector2(1,0):
			AniSprite.frame = 2
		Vector2(0, -1):
			AniSprite.frame = 4
		Vector2(0, 1):
			AniSprite.frame = 0
		Vector2(-1,-1):
			AniSprite.frame = 5
		Vector2(1,-1):
			AniSprite.frame = 3
		Vector2(1, 1):
			AniSprite.frame = 1
		Vector2(-1, 1):
			AniSprite.frame = 7
