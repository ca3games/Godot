extends Node2D

export(NodePath) var TopLeftPath
export(NodePath) var BottomRightPath
onready var TopLeft = get_node(TopLeftPath)
onready var BottomRight = get_node(BottomRightPath)
var unit = Vector2.ZERO
export(NodePath) var PlayerPath
onready var Player = get_node(PlayerPath)
var playerpos = Vector2.ZERO
var mapunit = Vector2.ZERO
export(NodePath) var EnemiesManagerPath
onready var EnemiesManager = get_node(EnemiesManagerPath)
export(PackedScene) var Enemy
export(NodePath) var VeggiesManagerPath
onready var Veggies = get_node(VeggiesManagerPath)
export(PackedScene) var Veggie
export(NodePath) var CookiesManagerPath
onready var Cookies = get_node(CookiesManagerPath)
export(PackedScene) var cooky
export(NodePath) var BossPath
onready var Boss = get_node(BossPath)
export(PackedScene) var bossy

func _ready():
	yield(get_tree(), "idle_frame")
	unit.x = TopLeft.global_transform.origin.x - BottomRight.global_transform.origin.x
	unit.y = TopLeft.global_transform.origin.z - BottomRight.global_transform.origin.z
	unit.x /= 20
	unit.y /= 20
	
	mapunit.x = $TopLeft.position.x - $BottomRight.position.x
	mapunit.y = $TopLeft.position.y - $BottomRight.position.y
	
	mapunit.x /= 20
	mapunit.y /= 20
	
	var e = EnemiesManager.get_child_count()
	for i in e:
		var tmp = Enemy.instance()
		tmp.enemy = EnemiesManager.get_child(i)
		$Enemies.add_child(tmp)
	
	var v = Veggies.get_child_count()
	for i in v:
		var tmp = Veggie.instance()
		tmp.enemy = Veggies.get_child(i)
		$Veggies.add_child(tmp)
	
	var c = Cookies.get_child_count()
	for i in c:
		var tmp = cooky.instance()
		tmp.enemy = Cookies.get_child(i)
		$Cookies.add_child(tmp)
		
	var b = Boss.get_child_count()
	for i in b:
		var tmp = bossy.instance()
		tmp.enemy = Boss.get_child(i)
		$Boss.add_child(tmp)

func _process(delta):
	var pos = TopLeft.global_transform.origin - Player.global_transform.origin
	var vector = Vector2(pos.x / unit.x, pos.z / unit.y)
	$Player.position = (vector * mapunit) * -1

	var e = $Enemies.get_child_count()
	for i in e:
		var e_pos = TopLeft.global_transform.origin - $Enemies.get_child(i).enemy.global_transform.origin
		var v_pos = Vector2(e_pos.x / unit.x, e_pos.z / unit.y)
		$Enemies.get_child(i).position = (v_pos * mapunit) * -1
	
	var v = $Veggies.get_child_count()
	for i in v:
		if is_instance_valid($Veggies.get_child(i).enemy):
			var v_pos = TopLeft.global_transform.origin - $Veggies.get_child(i).enemy.global_transform.origin
			var p_pos = Vector2(v_pos.x / unit.x, v_pos.z / unit.y)
			$Veggies.get_child(i).position = (p_pos * mapunit ) * -1
	
	var c = $Cookies.get_child_count()
	for i in c:
		if is_instance_valid($Cookies.get_child(i).enemy):
			var c_pos = TopLeft.global_transform.origin - $Cookies.get_child(i).enemy.global_transform.origin
			var pos_c = Vector2(c_pos.x / unit.x, c_pos.z / unit.y)
			$Cookies.get_child(i).position = (pos_c * mapunit ) * -1
		
	var b = $Boss.get_child_count()
	for i in b:
		if is_instance_valid($Boss.get_child(i).enemy):
			var b_pos = TopLeft.global_transform.origin - $Boss.get_child(i).enemy.global_transform.origin
			var pos_b = Vector2(b_pos.x / unit.x, b_pos.z / unit.y)
			$Boss.get_child(i).position = (pos_b * mapunit ) * -1


func DEADCOOKIE():
	var n = $Cookies.get_child_count()
	for i in n:
		$Cookies.get_child(i).queue_free()
	
	var c = Cookies.get_child_count()
	for i in c:
		var tmp = cooky.instance()
		tmp.enemy = Cookies.get_child(i)
		$Cookies.add_child(tmp)
	
	var vn = $Veggies.get_child_count()
	for i in vn:
		$Veggies.get_child(i).queue_free()
	
	var v = Veggies.get_child_count()
	for i in v:
		var tmp = Veggie.instance()
		tmp.enemy = Veggies.get_child(i)
		$Veggies.add_child(tmp)
	
