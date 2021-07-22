extends KinematicBody

export (NodePath) var EnemiesManagerPath
onready var Enemies = get_node(EnemiesManagerPath)

export(float) var MinReturnToChase
export(float) var MaxReturnToChase
export(int) var HP
export(int) var MaxHP

func _ready():
	UpdateGUI()

func ResetTarget():
	$FSM/CHASE.GetRandomTarget()

#damage == veggie HP
#weapon == weapon strenght for the dizzy timer
func Hit(damage):
	HP -= damage + Variables.WeaponDamage
	$FSM.ChangeState("IDLE")
	$FSM/IDLE.HIT(damage)
	UpdateGUI()

func UpdateGUI():
	$HP.text = str(HP)

func _process(delta):
	var pos = $"../".cameranode.unproject_position(self.global_transform.origin)
	$HP.rect_position = pos
	
	if HP < 1:
		$HP.text = str(int($DizzyTimer.time_left))
