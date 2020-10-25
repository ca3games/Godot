extends KinematicBody

signal PacificaStart
export (NodePath) var CameraPath
export (NodePath) var RosaNode
	

func PacificaStartPos(pos):
	translation = Vector3(pos.x, 1.25, pos.y)
	var camera = get_node(CameraPath)
	camera.translation = Vector3(pos.x, 6.8, pos.y + 5.2)
	var rosa = get_node(RosaNode)
	rosa.translation = Vector3(pos.x +3, 1.25, pos.y - 2)
