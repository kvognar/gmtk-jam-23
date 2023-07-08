extends CharacterBody2D

var detected_bullets = []

const speed = 500

enum STATES { DEFAULT, EXPLODING, BLINKING }
var state = STATES.DEFAULT
var respawn_point: Vector2
var bullet_pool

signal died

func _ready():
	respawn_point = global_position
	bullet_pool = get_node("/root/BulletPool")
	bullet_pool.mosquito = self

func _process(_delta):


	
	match state:
		STATES.DEFAULT:
			#	Debug button to test mosquito death
			if Input.is_key_pressed(KEY_SPACE):
				explode()
				return
			
			var new_vector = evasion_vector()
			if new_vector == Vector2.ZERO:
				new_vector = (respawn_point - global_position).normalized()
			velocity = new_vector * 400
			move_and_slide()
		STATES.EXPLODING:
			pass
		STATES.BLINKING:
			global_position = lerp(global_position, respawn_point, 0.5)
	
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
	if state == STATES.DEFAULT:
		explode()

func _on_bullet_avoider_area_entered(area):
	detected_bullets.append(area)

func _on_bullet_avoider_area_exited(area):
	detected_bullets.erase(area)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Explode":
		respawn()

func explode():
	$AnimationPlayer.play("Explode")
	$Emitter.set_firing(false)
	state = STATES.EXPLODING
	died.emit()

func respawn():
	$EffectsAnimationPlayer.play("blink")
	$AnimationPlayer.play("default")
	state = STATES.BLINKING
	global_position = respawn_point + Vector2(0, 400)

func _on_effects_animation_player_animation_finished(anim_name):
	if anim_name == "blink":
		state = STATES.DEFAULT
		$Emitter.set_firing(true)
