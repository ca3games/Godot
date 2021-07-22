extends "res://Code/Player/BaseState.gd"

func _ready():
	yield(get_tree(), "idle_frame")
	FSM.Root.get_node("Dizzy").hide()

func HIT(damage):
	FSM.Root.HP -= damage
	
	if FSM.Root.HP < 1:
		FSM.Root.get_node("DizzyTimer").start(Variables.WeaponDamage)
		FSM.Root.get_node("Dizzy").show()
		FSM.Root.get_node("HP").set("custom_colors/font_color", Color.blue)


func _on_DizzyTimer_timeout():
	FSM.ChangeState("CHASE")
	FSM.Root.get_node("Dizzy").hide()
	FSM.Root.HP = FSM.Root.MaxHP
	FSM.Root.UpdateGUI()
	FSM.Root.get_node("HP").set("custom_colors/font_color", Color.red)
