extends RigidBody3D

@export var brick_type: String

func _on_release():
	for snap in get_tree().get_nodes_in_group("snap_markers"):
		if snap.try_place(self):
			break
