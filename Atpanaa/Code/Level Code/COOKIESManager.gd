extends Spatial

export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)


export(int) var CookiesSpawned
export(NodePath) var TopLeftPath
export(NodePath) var BottomRightPath
onready var TopLeft = get_node(TopLeftPath)
onready var BottomRight = get_node(BottomRightPath)
export(PackedScene) var Cookies
export(NodePath) var SpawnYPosPath
onready var SpawnYPos = get_node(SpawnYPosPath)

func _ready():
	SpawnNewCookies()

func SpawnNewCookies():
	for i in CookiesSpawned:
		SpawnCookie()

func SpawnCookie():
	var cookie = Cookies.instance()
	var x = rand_range(TopLeft.global_transform.origin.x, BottomRight.global_transform.origin.x)
	var z = rand_range(TopLeft.global_transform.origin.z, BottomRight.global_transform.origin.z)
	add_child(cookie)
	cookie.global_transform.origin = Vector3(x, SpawnYPos.global_transform.origin.y, z)
