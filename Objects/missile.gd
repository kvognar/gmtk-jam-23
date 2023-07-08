extends Area2D

@export var target: Node2D;

const MAX_ANGULAR_VELOCITY = TAU/4

func _physics_process(delta):
	rotation = clamp(rotation, -TAU, TAU)
	
	var target_position = get_global_mouse_position()
#	print_debug(position.angle_to_point(target_position))
	
	var ideal_angle = position.angle_to_point(target_position) - TAU/4 - PI
	print_debug(ideal_angle)
	print_debug(rotation)
#
#
	var angle_difference = ideal_angle - rotation
#	if angle_difference > PI:
#		print_debug("too big")
#		angle_difference -= PI
#	if angle_difference < -PI:
#		print_debug("too little")
#		angle_difference += PI
#	print_debug(angle_difference)
#	print_debug(angle_difference)
##	print_debug(rotation)
##	print_debug(rotate_angle)
	var amount_to_rotate = clamp(angle_difference, -MAX_ANGULAR_VELOCITY, MAX_ANGULAR_VELOCITY) * delta

	
	
#
#	print_debug(amount_to_rotate)

	rotate(amount_to_rotate)
#	rotation = lerp(rotation, get_angle_to(target_position), 0.1)
#	print_debug(rotation)

	
