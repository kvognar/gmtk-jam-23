extends Node2D

@export var rotate_left_key: Key
@export var rotate_right_key: Key
@export var fire_key: Key

var rotate_speed = TAU/4

func _process(delta):
	var rotational_velocity = 0
	if Input.is_key_pressed(rotate_left_key):
		rotational_velocity -= rotate_speed
	if Input.is_key_pressed(rotate_right_key):
		rotational_velocity += rotate_speed
	if Input.is_key_pressed(fire_key):
		$Emitter.set_firing(true)
	else:
		$Emitter.set_firing(false)
		
	rotate(rotational_velocity * delta)
