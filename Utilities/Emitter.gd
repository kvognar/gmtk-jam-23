extends Node2D

@export var fire_speed: int
@export var fire_angle: float
@export var rotation_speed: float = 1.0
@export var bullet_type: PackedScene = load("res://Objects/big_bullet.tscn")
var bullet_pool: Node
var firing = true

func _ready():	
	bullet_pool = get_node("/root/BulletPool")

	
#func _process(delta):
#	pass
#	fire_angle += rotation_speed * delta

func emit():
	if !firing:
		return
	var new_bullet = bullet_type.instantiate()
	var fire_velocity = Vector2.from_angle(global_rotation) * fire_speed
	new_bullet.velocity = fire_velocity
	bullet_pool.add_child(new_bullet)
	new_bullet.global_position = global_position


func _on_timer_timeout():
	emit()
	
func set_firing(setting: bool):
	firing = setting
