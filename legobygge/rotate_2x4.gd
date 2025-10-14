extends Node3D

@export var tilt_degrees: float = 25.0   # tilt on X axis
@export var spin_speed_deg: float = 90.0 # degrees per second

func _ready():
	rotation_degrees.x = tilt_degrees

func _process(delta):
	rotate_y(deg_to_rad(spin_speed_deg * delta))
