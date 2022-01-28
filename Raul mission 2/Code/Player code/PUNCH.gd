extends "res://Code/Player code/Basic State.gd"

var start = true
export(String) var oneshot
export(String) var anim_name

export(NodePath) var MapPath
onready var Map = get_node(MapPath)

func Update(delta):
	FSM.state_machine.travel("PUNCH")
	FSM.AnimTree.set("parameters/PUNCH/blend_position", FSM.old_dir)

func EndAnim():
	FSM.ChangeState("IDLE")
	var coord = Map.world_to_map(FSM.Root.position)
	Map.set_cell(coord.x, coord.y, 1)
