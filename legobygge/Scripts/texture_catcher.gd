extends Node3D

@onready var sub_viewport = $SubViewport
@onready var mesh_instance_3d = $SubViewport/Node3D/MeshInstance3D

@export var mesh_to_snapshot: ArrayMesh
@export var snapshot_name: String

func _ready() -> void:
	mesh_instance_3d.mesh = mesh_to_snapshot
	await get_tree().create_timer(0.5).timeout
	var img = sub_viewport.get_viewport().get_texture().get_image()
	var image_path = "assets/Textures/%s.png" % snapshot_name
	img.save_png(image_path)
