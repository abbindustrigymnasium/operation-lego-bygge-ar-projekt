extends Node

signal found_table(pos: Vector3)

var right_hand_position = Vector3.ZERO
var left_hand_position = Vector3.ZERO

var closest_table_mesh: MeshInstance3D
func compare_table_distance_set_variable(mesh: MeshInstance3D) -> bool:
	print("here 4")
	if !closest_table_mesh:
		print("first run of function, setting default")
		closest_table_mesh = mesh
		return true
	var avg_hand_position: Vector3 = (right_hand_position + left_hand_position) / 2
	print("average hand pos:", avg_hand_position)
	var table: Vector3 = mesh.global_position
	print("table pos ", table)
	var closest: MeshInstance3D = closest_table_mesh
	
	var current_closest_dist = abs(table - avg_hand_position)
	print("current closest dist: ", current_closest_dist)
	if abs(table - avg_hand_position) < current_closest_dist:
		closest_table_mesh = mesh
		current_closest_dist = abs(table - avg_hand_position)
		print("new closest table found ", current_closest_dist, closest.global_position)
		return true
	else:
		return false
		

func set_right_hand_position(pos: Vector3) -> void:
	right_hand_position = pos
	
func set_left_hand_position(pos: Vector3) -> void:
	left_hand_position = pos

func get_right_hand_position() -> Vector3:
	return right_hand_position

func get_left_hand_position() -> Vector3:
	return left_hand_position
