extends Spatial


func ResetTargets():
	for i in get_children():
		i.ResetTarget()

func _process(delta):
	for i in get_children():
		if i.get_node("FSM/CHASE").target == null:
			i.ResetTarget()
