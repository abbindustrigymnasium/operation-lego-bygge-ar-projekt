extends Node3D

@export var grabcube: PackedScene
@export var two_by_four: PackedScene

var no_two_by_four_per_layer = [
	3,
	2,
	2,
	4,
	4,
	1
]

var no_two_by_two_per_layer = [	3,
	5,
	3,
	2,
	0,
	2
]


#var grabcube = preload("res://Grabcube.tscn")
#var two_by_four = preload("res://addons/godot-xr-tools/objects/2x4.tscn")

func spawn_bricks(layer: int):
	print("spawning bricks for layer, ", layer)
	print("spawning ", no_two_by_two_per_layer[layer], " blue pieces")
	print("spawning ", no_two_by_four_per_layer[layer], " red pieces")
	for i in range(no_two_by_two_per_layer[layer]):
		print("i = ", i)
		var brick = grabcube.instantiate()
		brick.show()
		print(brick)
		add_child(brick)
		print(brick.global_position)
	for j in range(no_two_by_four_per_layer[layer]):
		var brick = two_by_four.instantiate()
		add_child(brick)
