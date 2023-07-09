extends Node2D

@export var fire_key: Key
@export var open_key: Key
@export var load_key: Key
@export var missile_type: PackedScene

var bullet_pool: Node
var on_cooldown = false

enum STATE { CLOSED, OPEN, LOADED }
var state

func _ready():
	bullet_pool = get_node("/root/BulletPool")
	state = STATE.CLOSED

func _process(_delta):
	
	match state:
		STATE.CLOSED:
			if Input.is_key_pressed(open_key):
				open()
		STATE.OPEN:
			if !Input.is_key_pressed(open_key):
				close()
				return
			if Input.is_key_pressed(load_key):
				load_missiles()
		STATE.LOADED:
			if !Input.is_key_pressed(open_key):
				close()
	
			if Input.is_key_pressed(fire_key):
				if on_cooldown:
					return
				else:
					$Timer.start()
					on_cooldown = true
					var missile = missile_type.instantiate()
					missile.global_position = global_position
					missile.global_rotation = global_rotation
					missile.target_node = bullet_pool.mosquito
					bullet_pool.add_child(missile)


func close():
	state = STATE.CLOSED
	$AnimatedSprite2D.play("closed")
func open():
	state = STATE.OPEN
	$AnimatedSprite2D.play("open")
func load_missiles():
	state = STATE.LOADED
	$AnimatedSprite2D.play("loaded")

func _on_timer_timeout():
	on_cooldown = false
