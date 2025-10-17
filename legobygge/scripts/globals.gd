# Global variables and functions for use for
# global game state.

extends Node

signal found_table(pos: Vector3)

var right_hand_position = Vector3.ZERO
var left_hand_position = Vector3.ZERO

var closest_table_mesh: MeshInstance3D

func compare_table_distance_set_variable(mesh: MeshInstance3D) -> bool:
	if !closest_table_mesh:
		closest_table_mesh = mesh
		return true
	# Calculate the average hand position to compare agains.
	var avg_hand_position: Vector3 = (right_hand_position + left_hand_position) / 2
	var table_pos: Vector3 = mesh.global_transform.origin
	var closest: MeshInstance3D = closest_table_mesh
	
	var current_closest_pos: Vector3 = closest_table_mesh.global_transform.origin
	var current_closest_dist: float = current_closest_pos.distance_to(avg_hand_position)
	var new_dist = table_pos.distance_to(avg_hand_position)
	if new_dist < current_closest_dist:
		closest_table_mesh = mesh
		return true
	else:
		return false
		

# Simple getter/setter methods for use in above function.
func set_right_hand_position(pos: Vector3) -> void:
	right_hand_position = pos

func set_left_hand_position(pos: Vector3) -> void:
	left_hand_position = pos

func get_right_hand_position() -> Vector3:
	return right_hand_position

func get_left_hand_position() -> Vector3:
	return left_hand_position
