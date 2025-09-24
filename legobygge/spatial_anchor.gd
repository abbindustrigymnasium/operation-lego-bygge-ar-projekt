extends Node3D

@onready var mesh_instance = $Blueprint/GhostMesh

func setup_scene(entity: OpenXRFbSpatialEntity) -> void:
	var data := entity.custom_data
	
