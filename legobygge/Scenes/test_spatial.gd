extends StaticBody3D

@onready var label: Label3D = $Label3D

var found_table = false

# Set up mesh instances for the first found table and
# floor/walls.
func setup_scene(entity: OpenXRFbSpatialEntity) -> void:
	var semantic_labels: PackedStringArray = entity.get_semantic_labels()
	# Only mark table, floor and walls as mesh instances.
	if semantic_labels.count("table") == 0 and semantic_labels.count("floor") == 0 and semantic_labels.count("wall_face") == 0 and semantic_labels.count("invisible_wall_face") == 0:
		return

	label.text = semantic_labels[0]

	var collision_shape = entity.create_collision_shape()
	if collision_shape:
		add_child(collision_shape)

	if semantic_labels.count("table") > 0:
		var mesh_instance = entity.create_mesh_instance()
		var new_mat := StandardMaterial3D.new()
		# Mark the play table as slightly translucent white.
		new_mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		new_mat.albedo_color = Color(1, 1, 1, 0.5)
		mesh_instance.material_override = new_mat
		var new_closest_table_has_been_set = Globals.compare_table_distance_set_variable(mesh_instance)
		if new_closest_table_has_been_set:
			add_child(mesh_instance)
		else:
			mesh_instance.queue_free()
	if semantic_labels.count("table") > 0 and not found_table:
		Globals.emit_signal("found_table", collision_shape.global_position)
		# Mark only one table as played.
		found_table = true
