extends Node2D
onready var cell = preload("res://Scenes/Cell.tscn")
onready var cellRotate = preload("res://Scenes/Cell02.tscn")
var map
var width = 10
var height = 10
var rotate
var timer = 20
var off_y = 50
var off_x = 50

func _ready():
	set_process(true)
	map = []
	for x in range(width):
		map.append([])
		for y in range(height):
			var e = cell.instance()
			e.set_pos(Vector2(off_x + x*32, off_y + y*32))
			map[x].append(e)
			map[x][y].x = x
			map[x][y].y = y
			get_node("/root/Node/Map").add_child(map[x][y])
	
	rotate = []
	for x in range(3):
		rotate.append([])
		for y in range(3):
			var e = cellRotate.instance()
			e.set_pos(Vector2(off_x + (width*32) - ((x+1)*32), off_y + ((height+1)*32) + (y*32)))
			rotate[x].append(e)
			get_node("/root/Node/Rotate").add_child(rotate[x][y])
	_newRotatePiece()
	_FOCUSOFF()

func _process(delta):
	pass

func _rotate():
	if Global.side >= 3:
		Global.side = 0
	else:
		Global.side += 1
	_newRotatePiece()
	
func _MapClicked(x, y):
	get_node("/root/Node/Time").time = 20
	_SetPiece(x, y)
	_FOCUSOFF()
	_FOCUSON(x, y)
	_newRotatePiece()

func _SetPiece(x, y):
	if Global.tipo == 0:
		if Global.side == 0 or Global.side == 2:
			if IsValidVerticalLine(x, y):
				SetVerticalLine(x, y)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		else:
			if IsValidHorizontalLine(x, y):
				SetHorizontalLine(x, y)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
	if Global.tipo == 1:
		if Global.side == 0:
			if IsValidVerticalLine(x, y) and IsValid(x+1, y+1):
				SetVerticalLine(x, y)
				SetCell(x+1, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 1:
			if IsValidHorizontalLine(x, y) and IsValid(x-1, y+1):
				SetHorizontalLine(x, y)
				SetCell(x-1, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 2:
			if IsValidVerticalLine(x, y) and IsValid(x-1, y-1):
				SetVerticalLine(x, y)
				SetCell(x-1, y-1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 3:
			if IsValidHorizontalLine(x, y) and IsValid(x+1, y-1):
				SetHorizontalLine(x, y)
				SetCell(x+1, y-1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
	if Global.tipo == 2:
		if Global.side == 0:
			if IsValidTwoHorizontal(x, x+1, y) and IsValidTwoHorizontal(x, x+1, y+1):
				SetTwoHorizontal(x, x+1, y)
				SetTwoHorizontal(x, x+1, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 1:
			if IsValidTwoHorizontal(x, x-1, y) and IsValidTwoHorizontal(x, x-1, y+1):
				SetTwoHorizontal(x, x-1, y)
				SetTwoHorizontal(x, x-1, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 2:
			if IsValidTwoHorizontal(x, x-1, y) and IsValidTwoHorizontal(x, x-1, y-1):
				SetTwoHorizontal(x, x-1, y)
				SetTwoHorizontal(x, x-1, y-1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 3:
			if IsValidTwoHorizontal(x, x+1, y) and IsValidTwoHorizontal(x, x+1, y-1):
				SetTwoHorizontal(x, x+1, y)
				SetTwoHorizontal(x, x+1, y-1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
	if Global.tipo == 3:
		if IsValidVerticalLine(x, y) and IsValidHorizontalLine(x, y):
			SetVerticalLine(x, y)
			SetHorizontalLine(x, y)
			CheckCombo(x, y, map[x][y].getColor())
			Global._newpiece()
	if Global.tipo == 4:
		if Global.side == 0:
			if IsValidTwoVertical(x, y, y-1) and IsValidTwoVertical(x+1, y, y+1):
				SetTwoVertical(x, y, y-1)
				SetTwoVertical(x+1, y, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 1:
			if IsValidTwoHorizontal(x, x+1, y) and IsValidTwoHorizontal(x, x-1, y+1):
				SetTwoHorizontal(x, x+1, y)
				SetTwoHorizontal(x, x-1, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 2:
			if IsValidTwoVertical(x-1, y, y-1) and IsValidTwoVertical(x, y, y+1):
				SetTwoVertical(x-1, y, y-1)
				SetTwoVertical(x, y, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 3:
			if IsValidTwoHorizontal(x, x+1, y-1) and IsValidTwoHorizontal(x-1, x, y):
				SetTwoHorizontal(x, x+1, y-1)
				SetTwoHorizontal(x-1, x, y)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
	if Global.tipo == 5:
		if Global.side == 0:
			if IsValidTwoVertical(x, y, y+1) and IsValidTwoVertical(x+1, y, y-1):
				SetTwoVertical(x, y, y+1)
				SetTwoVertical(x+1, y, y-1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 1:
			if IsValidTwoHorizontal(x, x-1, y) and IsValidTwoHorizontal(x, x+1, y+1):
				SetTwoHorizontal(x, x-1, y)
				SetTwoHorizontal(x, x+1, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 2:
			if IsValidTwoVertical(x-1, y, y+1) and IsValidTwoVertical(x, y, y-1):
				SetTwoVertical(x-1, y, y+1)
				SetTwoVertical(x, y, y-1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 3:
			if IsValidTwoHorizontal(x, x-1, y-1) and IsValidTwoHorizontal(x, x+1, y):
				SetTwoHorizontal(x, x-1, y-1)
				SetTwoHorizontal(x, x+1, y)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
	if Global.tipo == 6:
		if Global.side == 0:
			if IsValidVerticalLine(x, y) and IsValidHorizontalLine(x, y-1):
				SetVerticalLine(x, y)
				SetHorizontalLine(x, y-1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 1:
			if IsValidVerticalLine(x+1, y) and IsValidHorizontalLine(x, y):
				SetHorizontalLine(x, y)
				SetVerticalLine(x+1, y)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 2:
			if IsValidVerticalLine(x, y) and IsValidHorizontalLine(x, y+1):
				SetVerticalLine(x, y)
				SetHorizontalLine(x, y+1)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()
		if Global.side == 3:
			if IsValidVerticalLine(x-1, y) and IsValidHorizontalLine(x, y):
				SetHorizontalLine(x, y)
				SetVerticalLine(x-1, y)
				CheckCombo(x, y, map[x][y].getColor())
				Global._newpiece()


func _FOCUSOFF():
	for x in range(width):
		for y in range(height):
			map[x][y]._hide()

func _FOCUSON(x, y):
	if Global.tipo == 0:
		if Global.side == 0 or Global.side == 2:
			if IsValidVerticalLine(x, y):
				ShowVerticalLine(x, y)
		else:
			if IsValidHorizontalLine(x, y):
				ShowHorizontalLine(x, y)
	if Global.tipo == 1:
		if Global.side == 0:
			if IsValidVerticalLine(x, y) and IsValid(x+1, y+1):
				ShowVerticalLine(x, y)
				ShowCell(x+1, y+1)
		if Global.side == 1:
			if IsValidHorizontalLine(x, y) and IsValid(x-1, y+1):
				ShowHorizontalLine(x, y)
				ShowCell(x-1, y+1)
		if Global.side == 2:
			if IsValidVerticalLine(x, y) and IsValid(x-1, y-1):
				ShowVerticalLine(x, y)
				ShowCell(x-1, y-1)
		if Global.side == 3:
			if IsValidHorizontalLine(x, y) and IsValid(x+1, y-1):
				ShowHorizontalLine(x, y)
				ShowCell(x+1, y-1)
	if Global.tipo == 2:
		if Global.side == 0:
			if IsValidTwoHorizontal(x, x+1, y) and IsValidTwoHorizontal(x, x+1, y+1):
				ShowTwoHorizontal(x, x+1, y)
				ShowTwoHorizontal(x, x+1, y+1)
		if Global.side == 1:
			if IsValidTwoHorizontal(x, x-1, y) and IsValidTwoHorizontal(x, x-1, y+1):
				ShowTwoHorizontal(x, x-1, y)
				ShowTwoHorizontal(x, x-1, y+1)
		if Global.side == 2:
			if IsValidTwoHorizontal(x, x-1, y) and IsValidTwoHorizontal(x, x-1, y-1):
				ShowTwoHorizontal(x, x-1, y)
				ShowTwoHorizontal(x, x-1, y-1)
		if Global.side == 3:
			if IsValidTwoHorizontal(x, x+1, y) and IsValidTwoHorizontal(x, x+1, y-1):
				ShowTwoHorizontal(x, x+1, y)
				ShowTwoHorizontal(x, x+1, y-1)
	if Global.tipo == 3:
		if IsValidVerticalLine(x, y) and IsValidHorizontalLine(x, y):
			ShowVerticalLine(x, y)
			ShowHorizontalLine(x, y)
	if Global.tipo == 4:
		if Global.side == 0:
			if IsValidTwoVertical(x, y, y-1) and IsValidTwoVertical(x+1, y, y+1):
				ShowTwoVertical(x, y, y-1)
				ShowTwoVertical(x+1, y, y+1)
		if Global.side == 1:
			if IsValidTwoHorizontal(x, x+1, y) and IsValidTwoHorizontal(x, x-1, y+1):
				ShowTwoHorizontal(x, x+1, y)
				ShowTwoHorizontal(x, x-1, y+1)
		if Global.side == 2:
			if IsValidTwoVertical(x-1, y, y-1) and IsValidTwoVertical(x, y, y+1):
				ShowTwoVertical(x-1, y, y-1)
				ShowTwoVertical(x, y, y+1)
		if Global.side == 3:
			if IsValidTwoHorizontal(x, x+1, y-1) and IsValidTwoHorizontal(x-1, x, y):
				ShowTwoHorizontal(x, x+1, y-1)
				ShowTwoHorizontal(x-1, x, y)
	if Global.tipo == 5:
		if Global.side == 0:
			if IsValidTwoVertical(x, y, y+1) and IsValidTwoVertical(x+1, y, y-1):
				ShowTwoVertical(x, y, y+1)
				ShowTwoVertical(x+1, y, y-1)
		if Global.side == 1:
			if IsValidTwoHorizontal(x, x-1, y) and IsValidTwoHorizontal(x, x+1, y+1):
				ShowTwoHorizontal(x, x-1, y)
				ShowTwoHorizontal(x, x+1, y+1)
		if Global.side == 2:
			if IsValidTwoVertical(x-1, y, y+1) and IsValidTwoVertical(x, y, y-1):
				ShowTwoVertical(x-1, y, y+1)
				ShowTwoVertical(x, y, y-1)
		if Global.side == 3:
			if IsValidTwoHorizontal(x, x-1, y-1) and IsValidTwoHorizontal(x, x+1, y):
				ShowTwoHorizontal(x, x-1, y-1)
				ShowTwoHorizontal(x, x+1, y)
	if Global.tipo == 6:
		if Global.side == 0:
			if IsValidVerticalLine(x, y) and IsValidHorizontalLine(x, y-1):
				ShowVerticalLine(x, y)
				ShowHorizontalLine(x, y-1)
		if Global.side == 1:
			if IsValidVerticalLine(x+1, y) and IsValidHorizontalLine(x, y):
				ShowHorizontalLine(x, y)
				ShowVerticalLine(x+1, y)
		if Global.side == 2:
			if IsValidVerticalLine(x, y) and IsValidHorizontalLine(x, y+1):
				ShowVerticalLine(x, y)
				ShowHorizontalLine(x, y+1)
		if Global.side == 3:
			if IsValidVerticalLine(x-1, y) and IsValidHorizontalLine(x, y):
				ShowHorizontalLine(x, y)
				ShowVerticalLine(x-1, y)

func _newRotatePiece():
	_cleanRotate()
	if Global.tipo == 0:
		if Global.side == 0 or Global.side == 2:
			MakeVerticalLineRotate(1)
		else:
			MakeHorizontalLineRotate(1)
	if Global.tipo == 1:
		if Global.side == 0:
			MakeVerticalLineRotate(1)
			MakeCellRotate(0,2)
		if Global.side == 1:
			MakeHorizontalLineRotate(1)
			MakeCellRotate(2, 2)
		if Global.side == 2:
			MakeVerticalLineRotate(1)
			MakeCellRotate(2, 0)
		if Global.side == 3:
			MakeHorizontalLineRotate(1)
			MakeCellRotate(0, 0)
	if Global.tipo == 2:
		if Global.side == 0:
			MakeTwoHorizontalLeft(1)
			MakeTwoHorizontalLeft(2)
		if Global.side == 1:
			MakeTwoHorizontalRight(1)
			MakeTwoHorizontalRight(2)
		if Global.side == 2:
			MakeTwoHorizontalRight(1)
			MakeTwoHorizontalRight(0)
		if Global.side == 3:
			MakeTwoHorizontalLeft(1)
			MakeTwoHorizontalLeft(0)
	if Global.tipo == 3:
		MakeCrossRotate()
	if Global.tipo == 4:
		if Global.side == 0:
			MakeTwoVerticalUp(1)
			MakeTwoVerticalBottom(0)
		if Global.side == 1:
			MakeTwoHorizontalLeft(1)
			MakeTwoHorizontalRight(2)
		if Global.side == 2:
			MakeTwoVerticalUp(2)
			MakeTwoVerticalBottom(1)
		if Global.side == 3:
			MakeTwoHorizontalRight(1)
			MakeTwoHorizontalLeft(0)
	if Global.tipo == 5:
		if Global.side == 0:
			MakeTwoVerticalBottom(1)
			MakeTwoVerticalUp(0)
		if Global.side == 1:
			MakeTwoHorizontalRight(1)
			MakeTwoHorizontalLeft(2)
		if Global.side == 2:
			MakeTwoVerticalBottom(2)
			MakeTwoVerticalUp(1)
		if Global.side == 3:
			MakeTwoHorizontalLeft(1)
			MakeTwoHorizontalRight(0)
	if Global.tipo == 6:
		if Global.side == 0:
			MakeHorizontalLineRotate(0)
			MakeVerticalLineRotate(1)
		if Global.side == 1:
			MakeVerticalLineRotate(0)
			MakeHorizontalLineRotate(1)
		if Global.side == 2:
			MakeHorizontalLineRotate(2)
			MakeVerticalLineRotate(1)
		if Global.side == 3:
			MakeHorizontalLineRotate(1)
			MakeVerticalLineRotate(2)

func CheckCombo(x, y, colour):
	if CheckCell(x, y, colour) and CheckCell(x-1, y, colour) and CheckCell(x-2, y, colour) and CheckCell(x-3, y, colour):
		_Combo(x, y, colour)
		CleanCombo()
		Values._score()
		Values.fanfare()
	if CheckCell(x, y, colour) and CheckCell(x+1, y, colour) and CheckCell(x+2, y, colour) and CheckCell(x+3, y, colour):
		_Combo(x, y, colour)
		CleanCombo()
		Values._score()
		Values.fanfare()
	if CheckCell(x, y, colour) and CheckCell(x, y-1, colour) and CheckCell(x, y-2, colour) and CheckCell(x, y-3, colour):
		_Combo(x, y, colour)
		CleanCombo()
		Values._score()
		Values.fanfare()
	if CheckCell(x, y, colour) and CheckCell(x, y+1, colour) and CheckCell(x, y+2, colour) and CheckCell(x, y+3, colour):
		_Combo(x, y, colour)
		CleanCombo()
		Values._score()
		Values.fanfare()
		
func CheckCell(x, y, colour):
	if _OldValid(x, y) and map[x][y].getColor() == colour:
		return true
	else:
		return false

func _Combo(x, y, colour):
	if not _OldValid(x, y):
		return	
	if map[x][y].getColor() != colour:
		return
	else:
		if map[x][y].ComboCheck != false:
			return
		else:
			map[x][y].ComboCheck = true
			_Combo(x-1, y, colour)
			_Combo(x+1, y, colour)
			_Combo(x, y-1, colour)
			_Combo(x, y+1, colour)

func CleanCombo():
	for x in range(width):
		for y in range(height):
			if map[x][y].ComboCheck:
				Values.combototal += 1
				map[x][y]._combo()

func _cleanRotate():
	for x in range(3):
		for y in range(3):
			rotate[x][y]._changeColor(5)

func MakeCellRotate(x, y):
	rotate[x][y]._changeColor(Global.colour)

func MakeTwoHorizontalLeft(y):
	MakeCellRotate(0, y)
	MakeCellRotate(1, y)

func MakeCrossRotate():
	MakeCellRotate(1, 1)
	MakeCellRotate(0, 1)
	MakeCellRotate(2, 1)
	MakeCellRotate(1, 2)
	MakeCellRotate(1, 0)

func MakeTwoHorizontalRight(y):
	MakeCellRotate(1, y)
	MakeCellRotate(2, y)
	
func MakeTwoVerticalUp(x):
	MakeCellRotate(x, 0)
	MakeCellRotate(x, 1)

func MakeTwoVerticalBottom(x):
	MakeCellRotate(x, 2)
	MakeCellRotate(x, 1)

func MakeVerticalLineRotate(x):
	rotate[x][1]._changeColor(Global.colour)
	rotate[x][0]._changeColor(Global.colour)
	rotate[x][2]._changeColor(Global.colour)

func MakeHorizontalLineRotate(y):
	rotate[1][y]._changeColor(Global.colour)
	rotate[0][y]._changeColor(Global.colour)
	rotate[2][y]._changeColor(Global.colour)
	
func MakeBombRotate():
	MakeCellRotate(1,1)
	MakeCellRotate(0, 0)
	MakeCellRotate(0, 2)
	MakeCellRotate(2, 0)
	MakeCellRotate(2, 2)

func MakeCell(x, y):
	if IsValid(x, y):
		map[x][y]._changeColor(Global.colour)

func IsValidVerticalLine(x, y):
	if IsValid(x, y) and IsValid(x, y-1) and IsValid(x, y+1):
		return true
	else:
		return false

func IsValidHorizontalLine(x, y):
	if IsValid(x, y) and IsValid(x-1, y) and IsValid(x+1, y):
		return true
	else:
		return false

func IsValidTwoHorizontal(x, x2, y):
	if IsValid(x, y) and IsValid(x2, y):
		return true
	else:
		return false
		
func ShowTwoHorizontal(x, x2, y):
	ShowCell(x, y)
	ShowCell(x2, y)

func SetTwoHorizontal(x, x2, y):
	SetCell(x, y)
	SetCell(x2, y)

func ShowTwoVertical(x, y, y2):
	ShowCell(x, y)
	ShowCell(x, y2)

func SetTwoVertical(x, y, y2):
	SetCell(x, y)
	SetCell(x, y2)

func IsValidTwoVertical(x, y, y2):
	if IsValid(x, y) and IsValid(x, y2):
		return true
	else:
		return false

func ShowHorizontalLine(x, y):
	ShowCell(x-1, y)
	ShowCell(x+1, y)
	ShowCell(x, y)

func SetHorizontalLine(x, y):
	SetCell(x-1, y)
	SetCell(x+1, y)
	SetCell(x, y)

func ShowVerticalLine(x, y):
	ShowCell(x, y)
	ShowCell(x, y-1)
	ShowCell(x, y+1)

func SetVerticalLine(x, y):
	SetCell(x, y)
	SetCell(x, y-1)
	SetCell(x, y+1)

func OldVerticalLine(x, y):
	map[x][y]._show()
	map[x][y-1]._show()
	map[x][y+1]._show()

func ShowCell(x, y):
	if IsValid(x, y):
		map[x][y]._show()

func SetCell(x, y):
	if IsValid(x, y):
		map[x][y]._changeColor(Global.colour)

func IsValid(x, y):
	if x < 0 or y < 0 or x >= width or y >= height:
		return false
	else:
		if map[x][y]._empty():
			return true
		else:
			return false

func _OldValid(x, y):
	if x < 0 or y < 0 or x >= width or y >= height:
		return false
	else:
		return true
