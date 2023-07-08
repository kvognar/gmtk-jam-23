extends Node2D

@export var fire_key: Key
@export var missile_type: PackedScene

var bullet_pool: Node
var on_cooldown = false

func _ready():
	bullet_pool = get_node("/root/BulletPool")

func _process(_delta):
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


func _on_timer_timeout():
	on_cooldown = false
