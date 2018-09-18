extends Sprite

var viewport = null
var sprite = null
var viewport_sprite = null


func _ready():
	
	viewport = get_node("/root/Node/Viewport")
	viewport_sprite = get_node("/root/Node/Level")

	# Assign the sprite's texture to the viewport texture
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	
	# Let two frames pass to make sure the screen was captured
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	viewport_sprite.texture = viewport.get_texture()
	
	print (viewport_sprite.texture)
	
	set_process(true)

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
