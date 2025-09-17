extends Node

signal found_table(pos: Vector3)

var right_hand_position = Vector3.ZERO
var left_hand_position = Vector3.ZERO

var tables: Array = []

func set_right_hand_position(pos: Vector3) -> void:
	right_hand_position = pos
	
func set_left_hand_position(pos: Vector3) -> void:
	left_hand_position = pos

func get_right_hand_position() -> Vector3:
	return right_hand_position

func get_left_hand_position() -> Vector3:
	return left_hand_position

func push_new_table(table: MeshInstance3D) -> void:
	tables.push_front(table)

func purge_tables() -> void:
	if len(tables) == 0:
		return
	var avg_hand_position = (right_hand_position + left_hand_position) / 2
	var closest = tables[0]
	var current_closest_dist = abs(tables[0] - avg_hand_position)
	for table in tables:
		if abs(table - avg_hand_position) < current_closest_dist:
			closest = table
			current_closest_dist = abs(table - avg_hand_position)
	print("closest table found ", current_closest_dist, closest.global_position)
