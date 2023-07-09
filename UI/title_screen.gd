extends Control

var exiting = false
signal change_to_scene(next_scene: PackedScene)

func _process(_delta):
	if Input.is_key_pressed(KEY_Q) and Input.is_key_pressed(KEY_P):
		print_debug("qp")
		if !exiting:
			print_debug("start the game!")
			exiting = true
			change_to_scene.emit(load("res://Scenes/intro.tscn"))
