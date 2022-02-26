extends KinematicBody

var Player
export(int) var damage
export(int) var HP
export(int) var MaxHP
onready var step = 255 / MaxHP

func _ready():
	HP = MaxHP
	yield(get_tree(), "idle_frame")
	$Chase.start(rand_range(2, 10))
	Player = $"../".Player


func _on_Player_body_entered(body):
	Variables.SetHP(-damage)


func _on_Chase_timeout():
	if rand_range(1, 10) < 5:
		$FSM.current = $FSM/CHASE
	else:
		$FSM.current = $FSM/IDLE
	
	$Chase.start(rand_range(2, 10))


func _on_Bomb_body_entered(body):
	HP -= body.Damage
	var color = Color8(255, (step*HP), (step*HP), 255)
	$MeshInstance.material_override.albedo_color = color
	
	if HP < 1:
		self.queue_free()
