extends KinematicBody

export (NodePath) var EnemiesManagerPath
onready var Enemies = get_node(EnemiesManagerPath)

export(float) var MinReturnToChase
export(float) var MaxReturnToChase

func ResetTarget():
	$FSM/CHASE.GetRandomTarget()
