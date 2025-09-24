extends RigidBody3D

var has_not_moved = true
var delta_sum = 0.0

func _process(delta: float) -> void:
	delta_sum += delta
	if delta_sum >= 1.0:
		delta_sum = 0.0
		print(global_position)
	if has_not_moved and Globals.closest_table_mesh:
		has_not_moved = false
		global_position = Globals.closest_table_mesh.global_position
		global_position.y += 1.0
