extends GridContainer

export(PackedScene) var Tile
var Map = []
onready var mapvars = Variables.get_node("BoardGame")
onready var size = Vector2(11,11)
var active = true
onready var Battle = "res://Scenes/Battle/Maps/Roguelite/Level1.tscn"
export(NodePath) var CameraPath
onready var mycamera = get_node(CameraPath)
export(Vector2) var CameraOff

func _ready():
	self.columns = size.x
	mapvars.home = Vector2(size.x/2, size.y/2)
	mapvars.playerpos = Vector2(mapvars.home.x, mapvars.home.y+1)
	CreateMap()
	SpawnMap()
	SpawnWave(10)
	UpdateMapTiles()
	var pos = get_rect().position + (Vector2(size.x/2, size.y/2) * 32) + CameraOff
	mycamera.position = pos

func _process(delta):
	if active:
		PlayerTurn()
		UpdateMapTiles()

func UpdateMapTiles():
	ClearMap()
	ChangeTile(mapvars.home.x, mapvars.home.y, "TOWN")
	SetEnemyTiles()
	ChangeTile(mapvars.playerpos.x, mapvars.playerpos.y, "PLAYER")
	UpdateMap()

func ChangeTile(x, y, id):
	Map[y][x].ChangePic(id)

func PlayerTurn():
	var move = GetAxisMovement()
	if move != Vector2.ZERO:
		var newpos = move + mapvars.playerpos
		if IsValid(newpos.x, newpos.y):
			$"../PlayerDelay".start(0.2)
			active = false
			mapvars.playerpos += move

func GetAxisMovement():
	var move = Vector2.ZERO
	
	var left = false
	var right = false
	var down = false
	var up = false
	
	if Input.is_action_pressed("LEFT"):
		left = true
	if Input.is_action_pressed("RIGHT"):
		right = true
	if Input.is_action_pressed("DOWN"):
		down = true
	if Input.is_action_pressed("UP"):
		up = true
	
	if left and not up and not down and not right:
		move.x = -1
	if right and not left and not up and not down:
		move.x = 1
	if up and not left and not right and not down:
		move.y = -1
	if down and not up and not left and not right:
		move.y = 1
	
	return move

func IsValid(x, y):
	if x < 0 or x >= size.x or y < 0 or y >= size.y:
		return false
	return true

func CreateMap():
	var id = 0
	for x in size.x:
		Map.append([])
		for y in size.y:
			Map[x].append([])
			var t = Tile.instance()
			t.id = id
			t.name = str(id)
			id += 1
			Map[x][y] = t
			
func SpawnMap():
	for x in size.x:
		for y in size.y:
			add_child(Map[x][y])

func ClearMap():
	for x in size.x:
		for y in size.y:
			Map[x][y].ChangePic("EMPTY")

func UpdateMap():
	for x in size.x:
		for y in size.y:
			Map[x][y].UpdatePic()


func _on_PlayerDelay_timeout():
	active = true

func SpawnWave(maxid):
	for i in maxid:
		var pos = GetAngle(i, maxid)
		mapvars.AddBandit(pos.x, pos.y)

func GetAngle(id, maxid):
	var half = size.y / 2
	var angle = (360 / maxid) * id
	var pos = Vector2.ZERO
	pos.x = int(cos(angle) * half + (half-1))
	pos.y = int(sin(angle) * half + (half))
	
	return pos

func SetEnemyTiles():
	for i in mapvars.BanditMax():
		var pos = mapvars.GetBanditPos(i)
		ChangeTile(pos.x, pos.y, "BASIC ENEMY")
