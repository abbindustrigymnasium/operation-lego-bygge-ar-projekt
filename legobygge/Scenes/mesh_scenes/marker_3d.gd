extends Marker3D
@export var required_brick_type: String
@export var surface_index: int
@export var layer_index: int
var occupied: bool = false
# var surface_index = 25

func try_place(player_brick: Node3D) -> bool:
	if occupied:
		return false
	if player_brick.brick_type != required_brick_type:
		return false

	var dist = global_transform.origin.distance_to(player_brick.global_transform.origin)
	if dist < 0.03: # tolerance in meters, adjust for AR
		# Replace ghost with "real" version
		var ghost_mesh = get_parent().get_node("MeshInstance3D")
		ghost_mesh.material_override = preload("res://assets/red_material.tres")
		player_brick.queue_free()
		occupied = true
		return true
	return false

func _ready() -> void:
	add_to_group("snap_markers")
