extends Node2D


func _ready():
	randomize()
	var f = $AnimatedSprite.get_sprite_frames().get_frame_count("Backgrounds")
	var i = randi()%f + 1
	$AnimationPlayer.play(str(i))
