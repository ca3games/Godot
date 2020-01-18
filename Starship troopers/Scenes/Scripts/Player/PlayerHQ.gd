extends Node

onready var UnitScript = load("res://Scenes/Scripts/Player/Unit.gd")
onready var PlayerScript = load("res://Scenes/Scripts/Player/Player.gd")
onready var BasicSoldier = preload("res://Scenes/Soldiers/BasicSoldier.tscn")
onready var MapGenerator = get_tree().get_root().get_node("Level/Scripts/MapGeneration")
onready var UnitsRoot = get_tree().get_root().get_node("Level/Units")
var Players = []
var initial_units = 1
var number_of_players = 1

func _ready():
	SpawnArmy()
	
func SpawnArmy():
	for p in range(0, number_of_players):
		Players.append([])
		Players[p] = PlayerScript.new()
		Players[p].Units = []
		for id in range(0, initial_units):
			Players[p].Units.append([])
			Players[p].Units[id] = UnitScript.new()
			Players[p].Units[id].Scene = BasicSoldier.instance()
			Players[p].Units[id].pos = Vector2(MapGenerator.MapSize.x/2, MapGenerator.MapSize.y/2)
			Players[p].Units[id].Scene.transform.origin = MapGenerator.GetPosition(Players[p].Units[id].pos)
			UnitsRoot.add_child(Players[p].Units[id].Scene)
			MapGenerator.SetUnitShadow(Players[p].Units[id].pos)
			
