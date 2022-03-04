extends RigidBody2D

export(int) var HP
var delay = false
onready var step = 255 / HP
export(PackedScene) var BasicCoin
export(PackedScene) var BigCoin


func Melee(d):
	if delay:
		return
	else:
		delay = true
		$Delay.start(0.4)
	HP -= d
	var id = step * HP
	var color = Color8(id, id, id, 255)
	$Tumbleweed.modulate = color
	if HP < 1:
		if randi()%4 +1 == 3:
			SpawnCoin()
		self.queue_free()

func SpawnCoin():
	var coin
	if randi()%5 +1 == 3:
		coin = BigCoin.instance()
	else:
		coin = BasicCoin.instance()
	coin.global_position = self.global_position
	get_parent().add_child(coin)

func _on_Delay_timeout():
	delay = false
