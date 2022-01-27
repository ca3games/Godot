extends "res://Code/Player code/Basic State.gd"

func END():
	FSM.ChangeState("IDLE")
	
func SpawnBomb():
	if Variables.GetMana() > Variables.get_node("Enemies").bomb_cost[Variables.current_bomb]:
		Variables.SetManaSpawn()
		var tmp = Variables.get_node("Enemies").Bombs[Variables.current_bomb].instance()
		FSM.Root.BombsManager.add_child(tmp)
		tmp.global_transform.origin = FSM.Root.global_transform.origin
