extends YSort

export(PackedScene) var Police01
export(PackedScene) var RedEnemy
export(NodePath) var LeftPath
export(NodePath) var RightPath
onready var Left = get_node(LeftPath)
onready var Right = get_node(RightPath)
export(NodePath) var TimerSpawnPath
onready var TimerSpawn = get_node(TimerSpawnPath)

func SpawnEnemy():
	var r = rand_range(1, 10)
	if r < 3:
		Spawn(RedEnemy)
	else:
		Spawn(Police01)

func Spawn(enemy):
	var tmp = enemy.instance()
	var x = rand_range(Left.position.x, Right.position.x)
	tmp.position = Vector2(x, 0)
	add_child(tmp)


func _on_SpawnEnemy_timeout():
	SpawnEnemy()
	var time = rand_range(1, 3)
	TimerSpawn.start(time)
