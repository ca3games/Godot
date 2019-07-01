extends Node2D

onready var generator = $Scripts/MapGenerator
onready var Tile = load("res://Code/Cell.gd")
var Map
var mapsize = Vector2(15,15)
var offset = 32
var Player
var Door
var idle = true
var GoldenPath

func _ready():
	yield(get_tree(), "idle_frame")
	MakeMap(true)
	$Camera2D.position = Vector2(mapsize.x/2*offset, mapsize.y/2*offset)


func MakeMap(new):
	Map = generator.MakeMap(mapsize, offset)
	Map[mapsize.x/2][mapsize.y-2].wall = false
	Map[mapsize.x/2][1].wall = false
	Player = Tile.new()
	Player.pos = Vector2(mapsize.x/2, mapsize.y-2)
	Door = Tile.new()
	Door.pos = Vector2(mapsize.x/2, 1)
	Door.cost = 999
	Door.checked = true
	
	generator.MakeDungeon(Map, Player.pos, Door.pos, mapsize)
	if new:
		generator.InstantiateMap(Map, mapsize)
	#generator.PrintDistance(Map, mapsize)
	#Map[Player.pos.x][Player.pos.y].Tile.ShowPlayer()
	$TileMap.set_cell(Player.pos.x, Player.pos.y, 2)
	#Map[Door.pos.x][Door.pos.y].Tile.ShowDoor()
	$TileMap.set_cell(Door.pos.x, Door.pos.y, 3)

	$Scripts/AStar.MakeGrid()
	GetPath(Player.pos, Door.pos)
	$Scripts/AStar.MakeNearBlocks(GoldenPath, Map, mapsize)
	Draw()
	
func _process(delta):
	if !idle:
		return
	if Input.is_action_just_released("LEFT"):
		Walk(Player.pos, Map, -1, 0)
	if Input.is_action_just_released("RIGHT"):
		Walk(Player.pos, Map, 1, 0)
	if Input.is_action_just_released("UP"):
		Walk(Player.pos, Map, 0, -1)
	if Input.is_action_just_released("DOWN"):
		Walk(Player.pos, Map, 0, 1)
	if Input.is_action_just_released("SPACE"):
		Restart()
	if Input.is_action_just_pressed("SHOW"):
		$Tween.interpolate_property($CanvasLayer/Sprite, "modulate", Color8(0,0,0,0), Color8(0,0,0,255), 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	Win()

func Restart():
	idle = false
	$Timer.start(0.8)
	Input.start_joy_vibration(0, 0.3, 0.3, 0.7)
	yield($Timer, "timeout")
	$Timer.start(0.6)
	playSound(-8)
	Input.start_joy_vibration(0, 0.5, 0, 0.3)
	yield($Timer, "timeout")
	$Timer.start(0.6)
	playSound(-15)
	Input.start_joy_vibration(0, 0, 0.5, 0.3)
	yield($Timer, "timeout")
	$Timer.start(0.6)
	playSound(-15)
	Input.start_joy_vibration(0, 0.7, 0, 0.5)
	yield($Timer, "timeout")
	idle = true
	get_tree().change_scene("res://Scenes/Map.tscn")

func Win():
	if Player.pos == Door.pos:
		Restart()

func Walk(Playerpos, map, x, y):
	if IsValid(Vector2(Playerpos.x+x, Playerpos.y+y)):
		if $TileMap.get_cell(Playerpos.x+x, Playerpos.y+y) != 1:
			Player.pos = Vector2(Playerpos.x+x, Playerpos.y+y)
			$TileMap.set_cell(Playerpos.x, Playerpos.y, 0)
			Draw()
			idle = false
			match(map[Playerpos.x+x][Playerpos.y+y].nearcost):
				30 : Cost30()
				15 : Cost10()
				50 : CostRed()
			idle = true
		else:
			idle = false
			$Timer.start(0.4)
			playSound(-12)
			Input.start_joy_vibration(0, 0.5, 0, 0.3)
			yield($Timer, "timeout")
			idle = true
	else:
		idle = false
		OutsideBounds()
		idle = true

func CostRed():
	$Timer.start(0.5)
	playSound(-10)
	Input.start_joy_vibration(0, 0.8, 0, 0.3)
	yield($Timer, "timeout")

func Cost30():
	$Timer.start(0.6)
	playSound(-15)
	Input.start_joy_vibration(0, 0.5, 0, 0.4)
	yield($Timer, "timeout")

func Cost10():
	$Timer.start(0.6)
	playSound(-20)
	Input.start_joy_vibration(0, 0, 0.3, 0.4)


func OutsideBounds():
	$Timer.start(0.4)
	playSound(-12)
	Input.start_joy_vibration(0, 0.6, 0, 0.3)
	yield($Timer, "timeout")
	$Timer.start(0.4)
	playSound(-8)
	Input.start_joy_vibration(0, 0, 0.6, 0.3)
	yield($Timer, "timeout")

func IsValid(pos):
	if pos.x > 0 and pos.x < mapsize.x and pos.y > 0 and pos.y < mapsize.y:
		return true
	return false

func GetPath(start, end):
	GoldenPath = $Scripts/AStar.GetPath(start, end)
	

func Draw():
	$Scripts/AStar.PrintPath(GoldenPath)
	$Scripts/AStar.PrintDistance(Map, mapsize)
	$TileMap.set_cell(Player.pos.x, Player.pos.y, 2)
	$TileMap.set_cell(Door.pos.x, Door.pos.y, 3)

func playSound(intensity):
	$Sound.play()
	$Sound.volume_db = intensity + 10

func _on_Timer_timeout():
	$Sound.stop()
	$Sound.volume_db = -6
