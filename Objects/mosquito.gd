extends CharacterBody2D

var detected_bullets = []

const speed = 500

func _process(delta):
	
	var new_vector = evasion_vector()
	if new_vector == Vector2.ZERO:
		new_vector = (Vector2(200, 200) - global_position).normalized()
	velocity = new_vector * 400

	
	move_and_slide()
	
func evasion_vector():
	var result_vector = Vector2.ZERO
	if detected_bullets.size() == 0:
		return result_vector
	
	var closest_bullet = detected_bullets[0]
	var closest_distance = (global_position - closest_bullet.global_position).length_squared()
	
	for bullet in detected_bullets:
		var distance = (global_position - bullet.global_position).length_squared()
		if distance < closest_distance:
			closest_bullet = bullet
			closest_distance = distance

	result_vector =  (global_position - closest_bullet.global_position).normalized()
	return result_vector

func _on_hurtbox_area_entered(_area):
	print_debug("ouch!")
	pass # Replace with function body.


func _on_bullet_avoider_area_entered(area):
	detected_bullets.append(area)

func _on_bullet_avoider_area_exited(area):
	detected_bullets.erase(area)

