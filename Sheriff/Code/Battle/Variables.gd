extends Node2D

var HP = 4
var level = 0
var wave = 0
var ammobasic = 100

func WinWave():
	wave += 1
	if wave > 5:
		wave = 0
		level += 1
