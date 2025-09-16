extends StaticBody3D

@onready var label: Label3D = $Label3D

func setup_scene(entity: OpenXRFbSpatialEntity) -> void:
	var semantic_labels: PackedStringArray = entity.get_semantic_labels()
	
	print(semantic_labels)
	if semantic_labels.count("table") == 0 and semantic_labels.count("floor") == 0 and semantic_labels.count("wall_face") == 0 and semantic_labels.count("invisible_wall_face") == 0:
		return

	label.text = semantic_labels[0]
	print(semantic_labels[0])

	var collision_shape = entity.create_collision_shape()
	if collision_shape:
		add_child(collision_shape)

	# if semantic_labels[0] == "global_mesh":
		# var mesh_instance = entity.create_mesh_instance()
		# if mesh_instance:
			# add_child(mesh_instance)
