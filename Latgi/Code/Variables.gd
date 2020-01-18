extends Node

enum typemode { human, ai, network }

var type
var P1won

enum emotion {
	empty_value, no_danger, dangerous_move, attacking_move
	}

func GameOver(p1winner):
	P1won = p1winner
	get_tree().change_scene("res://Scene/GameOver.tscn")