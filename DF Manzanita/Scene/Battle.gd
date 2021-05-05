extends Node2D

var score = 0

func GOL():
	score += 1
	$"CanvasLayer/SCORE".text = str(score)

func LOSE():
	if score > 0:
		score -= 1
	$"CanvasLayer/SCORE".text = str(score)
