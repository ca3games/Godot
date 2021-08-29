extends YSort

export(PackedScene) var Police01
export(PackedScene) var RedEnemy
export(PackedScene) var Car
export(PackedScene) var Boss
export(NodePath) var LeftPath
export(NodePath) var RightPath
export(NodePath) var BottomPath
onready var Left = get_node(LeftPath)
onready var Right = get_node(RightPath)
onready var Bottom = get_node(BottomPath)
export(NodePath) var TimerSpawnPath
onready var TimerSpawn = get_node(TimerSpawnPath)
export(NodePath) var CarTimerPath
onready var CarTimer = get_node(CarTimerPath)
export(NodePath) var CenterPath
onready var Center = get_node(CenterPath)
export(NodePath) var BossTimerPath
onready var BossTimer = get_node(BossTimerPath)

func _ready():
	BossTimer.start(60)

func SpawnEnemy():
	var r = rand_range(1, 10)
	if r < 3:
		Spawn(RedEnemy)
	else:
		Spawn(Police01)

func SpawnCar():
	var tmp = Car.instance()
	var x = Right.position.x
	var y = rand_range(Right.position.y, Bottom.position.y)
	tmp.position = Vector2(x, y)
	add_child(tmp)

func Spawn(enemy):
	var tmp = enemy.instance()
	var x = rand_range(Left.position.x, Right.position.x)
	tmp.position = Vector2(x, 0)
	add_child(tmp)

func SpawnBoss():
	var tmp = Boss.instance()
	tmp.position = Center.position
	$Bosses.add_child(tmp)

func _on_SpawnEnemy_timeout():
	SpawnEnemy()
	var time = rand_range(1, 3)
	TimerSpawn.start(time)


func _on_SpawnCar_timeout():
	SpawnCar()
	var time = rand_range(5, 8)
	CarTimer.start(time)
	


func _on_SpawnBoss_timeout():
	var i = $Bosses.get_child_count()
	if i < 1:
		SpawnBoss()
	var time = 60
	BossTimer.start(time)
