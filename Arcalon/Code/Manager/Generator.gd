extends Node2D

export (NodePath) var EnemiesManagerPath
onready var Enemies = get_node(EnemiesManagerPath)
export (PackedScene) var enemy01
export(PackedScene) var shooter01
export(NodePath) var BulletsManagerPath

func _ready():
	randomize()
	var sublevel = int(Variables.Level / 3) + 1
	for i in sublevel:
		if i > 20:
			return
		
		var monster = randi()% 2 + 1
		match (monster):
			1 : Spawn(shooter01, sublevel)
			2 : Spawn(shooter01, sublevel)
	

func Spawn(enemynode, sublevel):
	var enemy = enemynode.instance()
	var pos = Vector2.ZERO
	pos.x = rand_range($TopLeft.position.x, $BottomRight.position.x)
	pos.y = rand_range($TopLeft.position.y, $BottomRight.position.y)
	enemy.position = pos
	enemy.MaxHP = randi()% (sublevel * 10 + Variables.Level) * 5
	enemy.BulletsManagerPath = BulletsManagerPath
	Enemies.add_child(enemy)
