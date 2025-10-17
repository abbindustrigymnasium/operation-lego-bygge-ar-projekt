# Boilerplate to move hand based on tracking by headset.
extends XRController3D

var sum_of_deltas = 0.0

func _ready() -> void:
	Globals.set_right_hand_position(global_position)

func _process(delta: float) -> void:
	# Only run once every second.
	sum_of_deltas += delta
	if sum_of_deltas > 1.0:
		sum_of_deltas = 0.0
		Globals.set_right_hand_position(global_position)
