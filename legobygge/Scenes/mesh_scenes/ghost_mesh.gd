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

var completed_pieces = {
	0: false,
	1: false,
	2: false,
	3: false,
	4: false,
	5: false,
	6: false,
	7: false,
	8: false,
	9: false,
	10: false,
	11: false,
	12: false,
	13: false,
	14: false,
	15: false,
	16: false,
	17: false,
	18: false,
	19: false,
	20: false,
	21: false,
	22: false,
	23: false,
	24: false,
	25: false,
	26: false,
	27: false,
	28: false,
	29: false,
	30: false
}

var check_layer_complete_on_next_process = false

var current_layer := 0

func hide_all_layers():
	var mesh: MeshInstance3D = $GhostMesh
	var invis_mat = preload("res://assets/Textures/invisible_material_3d.tres")
	for i in mesh.mesh.get_surface_count():
		mesh.set_surface_override_material(i, invis_mat)
		

func set_piece_placed(surface: int):
	print("setting surface: ", surface, " as placed")
	if not completed_pieces.has(surface):
		return
	else:
		completed_pieces.set(surface, true)
		check_layer_complete_on_next_process = true
		

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


func advance_layer():
	current_layer += 1
	if current_layer < len(layers):
		$AudioStreamPlayer3D.play()
	else:
		$AudioStreamPlayer3D.stream = preload("res://assets/fanfare.ogg")
		$AudioStreamPlayer3D.play()
		$RestartArea.show()
		timer_running = false
		$TimerLabel.text = "Ditt resultat: " + str(round_decimals(elapsed_time, 1)) + "s"
		

	if current_layer < layers.size():
		show_layer(current_layer)
	

var elapsed_time: float = 0.0
var timer_running: bool = true

func _ready() -> void:
	$RestartArea.hide()
	hide_all_layers()
	print("showing layer", current_layer)
	show_layer(current_layer)

func calculate_up_dist() -> float:
	var mesh = Globals.closest_table_mesh
	return (mesh.scale.y + self.scale.y) / 2

# Godot does not have this functionality natively.
func round_decimals(num, decimals):
	return (round(num*pow(10, decimals))/pow(10, decimals))

func _process(delta: float) -> void:
	if timer_running:
		elapsed_time += delta
		$TimerLabel.text = str(round_decimals(elapsed_time, 1)) + "s"
	if Globals.closest_table_mesh:
		global_position = Globals.closest_table_mesh.global_position
		global_position.y += calculate_up_dist()
		self.show()
	
	if check_layer_complete_on_next_process:
		print("checking for layer completion")
		check_layer_complete_on_next_process = false
		var missing_piece = false
		for surface in layers[current_layer]:
			print("checking piece: ", surface, completed_pieces[surface])
			if not completed_pieces[surface]:
				print("piece missing: ", surface, completed_pieces[surface])
				missing_piece = true
		
		if not missing_piece:
			print("advancing layer")
			advance_layer()

func restart_game(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://main.tscn")
