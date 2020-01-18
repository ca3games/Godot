var cell
var type
var id
var player
var pos
var size
var alive = true
var Move = 0
var HP = 0
var FullHP = 0
var damage = 0

# types
# 6 is pawn
# 1 is tower
# 2 is horse
# 3 is king
# 4 is bishop
# 5 is queen

func GetTeam():
	return player
	
func GetMyPriority():
	var priority = 1
	match(type):
		6: priority = 2
		3: priority = 3
		1: priority = 5
		2: priority = 5
		4: priority = 7
		5: priority = 8
	return priority * 10
	
func GetDangerPriority():
	var priority = 1
	match(type):
		6: priority = 10
		3: priority = 2
		1: priority = 7
		2: priority = 7
		4: priority = 4
		5: priority = 5
	return priority * 10

func GetName():
	var name = ""
	match (type):
		6: name = "perro caca "
		1: name = "waifu tower "
		2: name = "waifu horse "
		3: name = "0n "
		4: name = "tulachi "
		5: name = "julian "
	return name

func GetDamage():
	var damage = 0
	match (type):
		3: damage = 10
		5: damage = 20
		4: damage = 30
		2: damage = 40
		1: damage = 50
		6: damage = 60
	
	return damage

func GetPossibleMovement():
	var posible = []
	
	match(type):
		0: return posible
		6:
			Add(0, 1, posible)
			AddDiagonals(0,1,1,0, posible)
		1:
			Arms(posible)
		2:
			Spider(posible)
		4:
			TwoFront(1, posible)
			Add(-1,0, posible)
			Add(1,0, posible)
			Add(0,-1, posible)
		5:
			Arms(posible)
			Spider(posible)
		3:
			Arms(posible)
			Spider(posible)
			MirrorV(1, 2, posible)
			MirrorV(-1,2, posible)
			MirrorH(2, 1, posible)
			MirrorH(2, -1, posible)
	
	return posible

func Arms(array):
	TwoFront(-1, array)
	TwoFront(1, array)
	TwoSide(-1, array)
	TwoSide(1, array)

func Spider(array):
	AddDiagonals(0,1,1,0, array)
	AddDiagonals(0,2,2,0, array)
	AddDiagonals(0,1,-1,0, array)
	AddDiagonals(0,2,-2,0, array)

func MirrorV(x, y, array):
	Add(x, y*-1, array)
	Add(x, y, array)

func MirrorH(x, y, array):
	Add(x*-1, y, array)
	Add(x, y, array)

func AddDiagonals(x, x2, y, y2, array):
	Add(x+x2, y+y2, array)
	Add(x-x2, y+y2, array)

func TwoFront(y, array):
	Add(0, 1*y, array)
	Add(0, 2*y, array)

func TwoSide(x, array):
	Add(1*x, 0, array)
	Add(2*x, 0, array)

func Add(x, y, array):
	if IsValid(pos.x +x, pos.y -y if player == 1 else pos.y +y):
		var position = Vector2(pos.x + x, pos.y -y if player == 1 else pos.y +y)
		array.append(position)

func IsValid(x, y):
	if x >= 0 and y >= 0 and x <= size.x -1 and y <= size.y -1:
		return true
	else:
		return false