extends Node2D

export(int) var switchid

func _ready():
	if Variables.get_node("StoryInterruptors").Interruptors[switchid]:
		$DoorKey.queue_free()
