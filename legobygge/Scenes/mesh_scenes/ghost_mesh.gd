extends Node3D

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
	var mesh = $GhostMesh
	var invis_mat = preload("res://assets/Textures/invisible_material_3d.tres")
	for i in mesh.mesh.get_layer_count():
		mesh.set_surface_override_material(i, invis_mat)

func show_layer(layer_index: int):
	var mesh = $GhostMesh
	var see_through_mat = preload("res://assets/Textures/transparent_material_3d.tres")
	for surface in layers[layer_index]:
		mesh.set_surface_override_material(surface, see_through_mat)
		
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
	show_layer(current_layer)
