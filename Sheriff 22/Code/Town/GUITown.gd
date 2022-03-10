extends CanvasLayer


func _ready():
	$Coins.text = str(Variables.money) + " GOLD"
