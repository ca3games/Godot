extends Node2D

var current = 0
onready var wave = Variables.level * Variables.wave
onready var enemy = preload("res://Scenes/Objects/Enemies.tscn")
var offset_x = 150
var offset_y = 150
var fadein = true

func _ready():
	$"../GUI/Level".text = "LEVEL " + str(Variables.level) + " | WAVES LEFT " + str(Variables.wave) + " | LEFT " + str(current)
	SpawnWave()


func _process(delta):
	current = get_child_count()
	$"../GUI/Level".text = "LEVEL " + str(Variables.level) + " | WAVES LEFT " + str(Variables.wave) + " | LEFT " + str(current)
	
	if current < 1 and fadein:
		fadein = false
		Reset()


func Killed():
	Variables.AddScore(100)

func Reset():
	Variables.wave -= 1		
	if Variables.wave < 1:
		Variables.level += 1
		Variables.wave = 3
	
	for i in $"../BULLETS".get_children():
		i.queue_free()
	
	$"../GUI".Hide()
	$"../GUI/Time".Hide()
	get_tree().get_root().get_node("Root/FADE").fadeIn()


func SpawnWave():
	current = Variables.level
	if current >= 8:
		current = 8
	
	var x = 0
	var y = 0
	
	for i in current:
		if x >= 3:
			x = 0
			y += 1
		var tmp = enemy.instance()
		var pos = $"../Start".position
		pos.x += x * offset_x
		pos.y += y * offset_y
		tmp.position = pos
		
		self.add_child(tmp)
		x += 1
	
	$"../Ball".position = $"../BallPos".position
	
	$"../GUI/Level".text = "LEVEL " + str(Variables.level) + " | WAVES LEFT " + str(Variables.wave) + " | LEFT " + str(current)
	$"../GUI".Show()
	$"../GUI/Time".Show()
	fadein = true
