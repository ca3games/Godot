extends KinematicBody

export (NodePath) var EnemiesManagerPath
onready var Enemies = get_node(EnemiesManagerPath)

export(float) var MinReturnToChase
export(float) var MaxReturnToChase
export(int) var HP
export(int) var MaxHP
export(int) var DamageKILL
export(int) var MinChangeTarget
export(int) var MaxChangeTarget


func ResetTarget():
	$FSM/CHASE.GetRandomTarget()

#damage == veggie HP
#weapon == weapon strenght for the dizzy timer
func Hit(damage):
	HP -= damage + Variables.WeaponDamage
	$FSM.ChangeState("IDLE")
	$FSM/IDLE.HIT(damage)
