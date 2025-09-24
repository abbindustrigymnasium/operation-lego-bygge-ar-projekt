extends Node3D

func _ready() -> void:
	self.hide()

func calculate_up_dist() -> float:
	var mesh = Globals.closest_table_mesh
	return (mesh.scale.y + self.scale.y) / 2

func _process(delta: float) -> void:
	if Globals.closest_table_mesh:
		global_position = Globals.closest_table_mesh.global_position
		global_position.y += calculate_up_dist()
		self.show()
