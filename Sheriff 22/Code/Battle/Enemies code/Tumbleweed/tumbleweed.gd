extends RigidBody2D

export(int) var HP
export(bool) var basiccoin
export(bool) var bigcoin
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
		SpawnCoin()
		self.queue_free()

func SpawnCoin():
	if not basiccoin and not bigcoin:
		return
	var coin
	if basiccoin:
		coin = BasicCoin.instance()
	if bigcoin:
		coin = BigCoin.instance()
	coin.global_position = self.global_position
	get_parent().add_child(coin)

func _on_Delay_timeout():
	delay = false
