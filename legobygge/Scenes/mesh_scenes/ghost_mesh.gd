extends Node3D

var two_by_four = [
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
]

var two_by_two = [
	16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30
]

var layers = [
	[0,5,7,16,17,28],
	[1,2,22,23,24,25,29],
	[6,8,18,19,30],
	[3,4,9,10,21,26],
	[11,12,13,14],
	[15,20,27]
]

var current_layer := 0

func hide_all_layers():
	var mesh: MeshInstance3D = $GhostMesh
	var invis_mat = preload("res://assets/Textures/invisible_material_3d.tres")
	for i in mesh.mesh.get_surface_count():
		mesh.set_surface_override_material(i, invis_mat)
		

func show_layer(layer_index: int):
	var mesh = $GhostMesh
	var see_through_mat_blue = preload("res://assets/Textures/transparent_material_3d.tres")
	var see_through_mat_red = preload("res://assets/Textures/transparent_material__red_3d.tres")
	for surface in layers[layer_index]:
		if surface in two_by_four:
			mesh.set_surface_override_material(surface, see_through_mat_red)
		else:
			mesh.set_surface_override_material(surface, see_through_mat_blue)
		# Get the Marker3D child that corresponds to this surface
		for child in mesh.get_children():
			if child.get("surface_index") == surface:
				print("getting snapzone")
				var snapzone = child.get_node_or_null("SnapZone")
				if snapzone:
					print("setting snapzone enabled for surface, ", surface)
					snapzone.enabled = true

func check_layer_complete():
	var markers = get_tree().get_nodes_in_group("snap_markers")
	for marker in markers:
		if marker.layer_index == current_layer and not marker.occupied:
			return false
	return true

func advance_layer():
	if check_layer_complete():
		current_layer += 1
		if current_layer < layers.size():
			show_layer(current_layer)

func _ready() -> void:
	hide_all_layers()
	print("showing layer", current_layer)
	show_layer(current_layer)

func calculate_up_dist() -> float:
	var mesh = Globals.closest_table_mesh
	return (mesh.scale.y + self.scale.y) / 2

func _process(delta: float) -> void:
	if Globals.closest_table_mesh:
		global_position = Globals.closest_table_mesh.global_position
		global_position.y += calculate_up_dist()
		self.show()
