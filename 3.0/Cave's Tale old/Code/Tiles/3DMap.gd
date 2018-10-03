extends Spatial

onready var view = get_node("Viewport")
onready var mesh = get_node("MeshInstance")


func _ready():
	mesh.mesh.material.albedo_texture = view.get_texture()
