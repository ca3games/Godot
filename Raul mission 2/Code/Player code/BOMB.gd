extends "res://Code/Player code/Basic State.gd"

func END():
	FSM.ChangeState("IDLE")
	
func SpawnBomb():
	FSM.Root.SceneRoot.ActionButtons.DeleteCommand()
