extends KinematicBody2D

export(NodePath) var CameraPath
onready var MyCamera = get_node(CameraPath)

export(NodePath) var SeedRootPath
onready var SeedRoot = get_node(SeedRootPath)

export(PackedScene) var SeedsPath
