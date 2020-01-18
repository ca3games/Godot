extends Node

onready var UnitScript = load("res://Scenes/Scripts/Player/Unit.gd")
onready var MapGenerator = get_tree().get_root().get_node("Level/Scripts/MapGeneration")
onready var UnitsRoot = get_tree().get_root().get_node("Level/Units")
onready var WarriorBug = preload("res://Scenes/Enemies/WarriorBug.tscn")

var Units = []
var level = 200


func _ready():
	ReSpawnEnemies()
	

func ReSpawnEnemies():
	for i in range(0, level):
		Units.append([])
		Units[i] = UnitScript.new()
		Units[i].Scene = WarriorBug.instance()
		Units[i].enemypos = []
		var random = MapGenerator.GetRandomCoord()
		Units[i].enemypos.append(Vector2(random.x-1, random.y))
		Units[i].enemypos.append(Vector2(random.x, random.y))
		Units[i].Scene.global_transform.origin = MapGenerator.GetPosition(Units[i].enemypos[0])
		MapGenerator.SetUnitShadow(Units[i].enemypos[0])
		MapGenerator.SetUnitShadow(Units[i].enemypos[1])
		UnitsRoot.add_child(Units[i].Scene)

