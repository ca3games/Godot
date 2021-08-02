extends Spatial

export(NodePath) var Playerpath
onready var Player = get_node(Playerpath)
#ID OF THE VARIABLES PACKED SCENE TO LOAD
export(Array, int) var EnemiesType
export (int) var MaxEnemies

export(NodePath) var TopLeftPath
export(NodePath) var BottomRightPath
export(NodePath) var YSpawnPath
onready var TopLeft = get_node(TopLeftPath)
onready var BottomRight = get_node(BottomRightPath)
onready var YSpawn = get_node(YSpawnPath)

func _ready():
	for i in MaxEnemies:
		Spawn(EnemiesType[0])

func Spawn(id):
	var tmp = Variables.get_node("Enemies").Enemies[id].instance()
	add_child(tmp)
	var pos = Vector3.ZERO
	pos.x = rand_range(TopLeft.global_transform.origin.x, BottomRight.global_transform.origin.x)
	pos.z = rand_range(TopLeft.global_transform.origin.z, BottomRight.global_transform.origin.z)
	pos.y = YSpawn.global_transform.origin.y
	tmp.global_transform.origin = pos
	
func _process(delta):
	var enemies = get_child_count()
	if enemies < 1:
		Variables.GameWin()
