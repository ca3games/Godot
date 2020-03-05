extends Node2D

func ChangeCell(x, y, map, type):
	map[x][y].type = type
	map[x][y].cell.ChangeType(type)

func IsLegal(x, y, size_x, size_y, map):
	if x < 0 or x >= size_x:
		return false
	
	if y < 0 or y >= size_y:
		return false
	
	if map[x][y].type != 4:
		return false
	return true

func MakeTwoVertical(x, y, map, type):
	ChangeCell(x, y, map, type)
	ChangeCell(x, y+1, map, type)

func CheckTwoVertical(x, y, size_x, size_y, map):
	if IsLegal(x, y, size_x, size_y, map) and IsLegal(x, y+1, size_x, size_y, map):
		return true
	else:
		return false
	
func MakeTwoHorizontal(x, y, map, type):
	ChangeCell(x, y, map, type)
	ChangeCell(x+1, y, map, type)

func CheckTwoHorizontal(x, y, size_x, size_y, map):
	if IsLegal(x, y, size_x, size_y, map) and IsLegal(x+1, y, size_x, size_y, map):
		return true
	else:
		return false

func MakeThreeVertical(x, y, map, type):
	ChangeCell(x, y, map, type)
	MakeTwoVertical(x, y+1, map, type)
	
func CheckThreeVertical(x, y, size_x, size_y, map):
	if IsLegal(x, y, size_x, size_y, map) and CheckTwoVertical(x, y+1, size_x, size_y, map):
		return true
	else:
		return false

func MakeThreeHorizontal(x, y, map, type):
	ChangeCell(x, y, map, type)
	MakeTwoHorizontal(x+1, y, map, type)

func CheckThreeHorizontal(x, y, size_x, size_y, map):
	if IsLegal(x, y, size_x, size_y, map) and CheckTwoHorizontal(x+1, y, size_x, size_y, map):
		return true
	else:
		return false
	
func Make_I(x, y, size_x, size_y, map, type, side, button):
	match(side):
		0:
			if !button:
				if CheckThreeVertical(x+1, y, size_x, size_y, map):
					MakeThreeVertical(x+1, y, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeVertical(x+1, y, map, type)
		1:
			if !button:
				if CheckThreeVertical(x+1, y, size_x, size_y, map):
					MakeThreeVertical(x+1, y, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeVertical(x+1, y, map, type)
		2:
			if !button:
				if CheckThreeHorizontal(x, y+1, size_x, size_y, map):
					MakeThreeHorizontal(x, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeHorizontal(x, y+1, map, type)
		3:
			if !button:
				if CheckThreeHorizontal(x, y+1, size_x, size_y, map):
					MakeThreeHorizontal(x, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeHorizontal(x, y+1, map, type)

func Make_J(x, y, size_x, size_y, map, type, side, button):
	match(side):
		0:
			if !button:
				if CheckThreeVertical(x+1, y, size_x, size_y, map) and IsLegal(x, y+2, size_x, size_y, map):
					MakeThreeVertical(x+1, y, map, type)
					ChangeCell(x, y+2, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeVertical(x+1, y, map, type)
				ChangeCell(x, y+2, map, type)
		1:
			if !button:
				if CheckThreeVertical(x+1, y, size_x, size_y, map) and IsLegal(x+2, y, size_x, size_y, map):
					MakeThreeVertical(x+1, y, map, type)
					ChangeCell(x+2, y, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeVertical(x+1, y, map, type)
				ChangeCell(x+2, y, map, type)
		2:
			if !button:
				if CheckThreeHorizontal(x, y+1, size_x, size_y, map) and IsLegal(x, y, size_x, size_y, map):
					MakeThreeHorizontal(x, y+1, map, type)
					ChangeCell(x, y, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeHorizontal(x, y+1, map, type)
				ChangeCell(x, y, map, type)
		3:
			if !button:
				if CheckThreeHorizontal(x, y+1, size_x, size_y, map) and IsLegal(x+2, y+2, size_x, size_y, map):
					MakeThreeHorizontal(x, y+1, map, type)
					ChangeCell(x+2, y+2, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeHorizontal(x, y+1, map, type)
				ChangeCell(x+2, y+2, map, type)

func Make_O(x, y, size_x, size_y, map, type, side, button):
	match(side):
		0:
			if !button:
				if CheckTwoHorizontal(x+1, y+1, size_x, size_y, map) and CheckTwoHorizontal(x+1, y+2, size_x, size_y, map):
					MakeTwoHorizontal(x+1, y+1, map, type)
					MakeTwoHorizontal(x+1, y+2, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x+1, y+1, map, type)
				MakeTwoHorizontal(x+1, y+2, map, type)
		1:
			if !button:
				if CheckTwoHorizontal(x, y, size_x, size_y, map) and CheckTwoHorizontal(x, y+1, size_x, size_y, map):
					MakeTwoHorizontal(x, y, map, type)
					MakeTwoHorizontal(x, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x, y, map, type)
				MakeTwoHorizontal(x, y+1, map, type)
		2:
			if !button:
				if CheckTwoHorizontal(x, y+1, size_x, size_y, map) and CheckTwoHorizontal(x, y+2, size_x, size_y, map):
					MakeTwoHorizontal(x, y+1, map, type)
					MakeTwoHorizontal(x, y+2, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x, y+1, map, type)
				MakeTwoHorizontal(x, y+2, map, type)
		3:
			if !button:
				if CheckTwoHorizontal(x+1, y, size_x, size_y, map) and CheckTwoHorizontal(x+1, y+1, size_x, size_y, map):
					MakeTwoHorizontal(x+1, y, map, type)
					MakeTwoHorizontal(x+1, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x+1, y, map, type)
				MakeTwoHorizontal(x+1, y+1, map, type)
			
func Make_S(x, y, size_x, size_y, map, type, side, button):
	match(side):
		0:
			if !button:
				if CheckTwoHorizontal(x+1, y+1, size_x, size_y, map) and CheckTwoHorizontal(x, y+2, size_x, size_y, map):
					MakeTwoHorizontal(x+1, y+1, map, type)
					MakeTwoHorizontal(x, y+2, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x+1, y+1, map, type)
				MakeTwoHorizontal(x, y+2, map, type)
		1:
			if !button:
				if CheckTwoHorizontal(x+1, y, size_x, size_y, map) and CheckTwoHorizontal(x, y+1, size_x, size_y, map):
					MakeTwoHorizontal(x+1, y, map, type)
					MakeTwoHorizontal(x, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x+1, y, map, type)
				MakeTwoHorizontal(x, y+1, map, type)
		2:
			if !button:
				if CheckTwoVertical(x, y, size_x, size_y, map) and CheckTwoVertical(x+1, y+1, size_x, size_y, map):
					MakeTwoVertical(x, y, map, type)
					MakeTwoVertical(x+1, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoVertical(x, y, map, type)
				MakeTwoVertical(x+1, y+1, map, type)
		3:
			if !button:
				if CheckTwoVertical(x+1, y, size_x, size_y, map) and CheckTwoVertical(x+2, y+1, size_x, size_y, map):
					MakeTwoVertical(x+1, y, map, type)
					MakeTwoVertical(x+2, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoVertical(x+1, y, map, type)
				MakeTwoVertical(x+2, y+1, map, type)
			
func Make_T(x, y, size_x, size_y, map, type, side, button):
	match(side):
		0:
			if !button:
				if CheckThreeHorizontal(x, y+1, size_x, size_y, map) and IsLegal(x+1, y+2, size_x, size_y, map):
					MakeThreeHorizontal(x, y+1, map, type)
					ChangeCell(x+1, y+2, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeHorizontal(x, y+1, map, type)
				ChangeCell(x+1, y+2, map, type)
		1:
			if !button:
				if CheckThreeHorizontal(x, y+1, size_x, size_y, map) and IsLegal(x+1, y, size_x, size_y, map):
					MakeThreeHorizontal(x, y+1, map, type)
					ChangeCell(x+1, y, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeHorizontal(x, y+1, map, type)
				ChangeCell(x+1, y, map, type)
		2:
			if !button:
				if CheckThreeVertical(x+1, y, size_x, size_y, map) and IsLegal(x, y+1, size_x, size_y, map):
					MakeThreeVertical(x+1, y, map, type)
					ChangeCell(x, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeVertical(x+1, y, map, type)
				ChangeCell(x, y+1, map, type)
		3:
			if !button:
				if CheckThreeVertical(x+1, y, size_x, size_y, map) and IsLegal(x+2, y+1, size_x, size_y, map):
					MakeThreeVertical(x+1, y, map, type)
					ChangeCell(x+2, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeThreeVertical(x+1, y, map, type)
				ChangeCell(x+2, y+1, map, type)
			
func Make_Z(x, y, size_x, size_y, map, type, side, button):
	match(side):
		0:
			if !button:
				if CheckTwoHorizontal(x, y+1, size_x, size_y, map) and CheckTwoHorizontal(x+1, y+2, size_x, size_y, map):
					MakeTwoHorizontal(x, y+1, map, type)
					MakeTwoHorizontal(x+1, y+2, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x, y+1, map, type)
				MakeTwoHorizontal(x+1, y+2, map, type)
		1:
			if !button:
				if CheckTwoHorizontal(x, y, size_x, size_y, map) and CheckTwoHorizontal(x+1, y+1, size_x, size_y, map):
					MakeTwoHorizontal(x, y, map, type)
					MakeTwoHorizontal(x+1, y+1, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoHorizontal(x, y, map, type)
				MakeTwoHorizontal(x+1, y+1, map, type)
		2:
			if !button:
				if CheckTwoVertical(x, y+1, size_x, size_y, map) and CheckTwoVertical(x+1, y, size_x, size_y, map):
					MakeTwoVertical(x, y+1, map, type)
					MakeTwoVertical(x+1, y, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoVertical(x, y+1, map, type)
				MakeTwoVertical(x+1, y, map, type)
		3:
			if !button:
				if CheckTwoVertical(x+1, y+1, size_x, size_y, map) and CheckTwoVertical(x+2, y, size_x, size_y, map):
					MakeTwoVertical(x+1, y+1, map, type)
					MakeTwoVertical(x+2, y, map, type)
					$"../".NewPiece()
					$"../../TimeBar".AddPieceTimer()
			else:
				MakeTwoVertical(x+1, y+1, map, type)
				MakeTwoVertical(x+2, y, map, type)

func IsValid(x, y, size_x, size_y):
	if x < 0 or x >= size_x:
		return false
	if y < 0 or y >= size_y:
		return false
	return true

func Combo(x, y, seed_x, seed_y, size_x, size_y, map, bomb_map, type):
	if not IsValid(x, y, size_x, size_y):
		return 0
	
	if bomb_map[x][y]:
		return 0
		
	if map[x][y].type == type:
		bomb_map[x][y] = true
		var distance = 0
		distance += abs(seed_x - x) + abs(seed_y - y)
		
		ChangeCell(x, y, map, 4)
		distance += Combo(x-1, y, seed_x, seed_y, size_x, size_y, map, bomb_map, type) + Combo(x+1, y, seed_x, seed_y, size_x, size_y, map, bomb_map, type) + Combo(x, y-1, seed_x, seed_y, size_x, size_y, map, bomb_map, type) + Combo(x, y+1, seed_x, seed_y, size_x, size_y, map, bomb_map, type)
		
		return distance
	else:
		return 0
