extends Node2D

var pos
var red = Color.red
var green = Color.green
var gray = Color.gray

func _ready():
	$Circle.hide()

func SetBrown():
	$Sprite.modulate = Color.brown

func Update(number, player, HP):
	if player == 1:
		$AnimatedSprite.flip_v = false
	else:
		$AnimatedSprite.flip_v = true
	
	if number != 0:
		$AnimatedSprite.show()
		$Life.max_value = HP.y
		$Life.value = HP.x
		$Life.show()
	else:
		$AnimatedSprite.hide()
		$Life.hide()
		return
	
	match(number):
		1: $AnimatedSprite.frame = 0
		2: $AnimatedSprite.frame = 1
		3: $AnimatedSprite.frame = 2
		4: $AnimatedSprite.frame = 3
		5: $AnimatedSprite.frame = 4
		6: $AnimatedSprite.frame = 5

func SetRed(color):
	if color == true:
		var team = get_tree().get_root().get_node("Map").ReturnID(pos)
		var turn = int(get_tree().get_root().get_node("Map").P1Turn)
		
		if $AnimatedSprite.visible == true:
			if (team.y == 1 and turn == 1) or (team.y == 2 and turn == 0):
				$Circle.modulate = gray
			else:
				$Circle.modulate = red
		else:
			$Circle.modulate = green
		$Circle.show()
	else:
		$Circle.hide()
		$score.hide()
		$attack.hide()
		$danger.hide()
		$SquareBar.hide()
		$id.hide()

func GetRed():
	if $Circle.modulate == green:
		return true
	else:
		return false

func GetTarget():
	if $Circle.modulate == red:
		return true
	else:
		return false

func IsBrown():
	if $Sprite.modulate == Color.brown:
		return true
	else:
		return false

func _Sprite_pressed():
	if Variables.type == Variables.typemode.network:
		get_tree().get_root().get_node("Map").SelectPieceNetwork(pos)
	else:
		get_tree().get_root().get_node("Map").SelectPiece(pos)
	
func ShowColor(color):
	$Circle.show()
	$Circle.modulate = color

func ShowScore(score, attack, id, danger):
	$score.text = str(score)
	$attack.text = str(attack)
	$id.text = str(id)
	$danger.text = str(danger)
	$danger.show()
	$id.show()
	$score.show()
	$attack.show()

func Hide():
	$Circle.hide()

func HideBar():
	$SquareBar.hide()

func ShowBar(color):
	$SquareBar.modulate = color
	$SquareBar.show()
