extends Area2D

@export var target: Node2D;

const MAX_ANGULAR_VELOCITY = TAU/4
const VELOCITY = 150
var target_node: Node2D
var target_position

func _physics_process(delta):
	if target_node:
		target_position = target_node.global_position
	else:
		target_position = get_global_mouse_position()

	var ideal_angle = position.angle_to_point(target_position)
#
	var angle_difference = ideal_angle - rotation
	
	# If the smallest adjustment angle requires rotating to > TAU or < -TAU, we need to
	# adjust here or the missile will try to go the "long way around" to stay between 0 and TAU.
	if angle_difference > PI:
		angle_difference -= TAU
	if angle_difference < -PI:
		angle_difference += TAU

	var amount_to_rotate = clamp(angle_difference, -MAX_ANGULAR_VELOCITY, MAX_ANGULAR_VELOCITY) * delta


	rotate(amount_to_rotate)
	position += Vector2.from_angle(rotation) * VELOCITY * delta


	
