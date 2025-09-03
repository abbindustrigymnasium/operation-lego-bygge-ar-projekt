extends XRNode3D

var time_passed := 0.0

func _process(delta: float) -> void:
	time_passed += delta
	if time_passed >= 1.0:
		time_passed = 0.0
		var x_pos = global_transform.origin.x
		Var y_pos = global_transform.origin.y
		var z_pos = global_transform.origin.z
		#print("Current X:", x_pos)
		#print("Current Y:", y_pos)
		#print("Current Z:", z_pos)
