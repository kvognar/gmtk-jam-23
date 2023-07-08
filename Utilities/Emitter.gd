extends Node2D

@export var fire_speed: int
@export var fire_angle: float
@export var rotation_speed: float = 1.0
@export var bullet_type: PackedScene = load("res://Objects/big_bullet.tscn")
var bullet_pool: Node

func _ready():	
	bullet_pool = get_node("/root/BulletPool")

	
func _process(delta):
	fire_angle += rotation_speed * delta

func emit():
	var new_bullet = bullet_type.instantiate()
	var fire_velocity = Vector2.from_angle(fire_angle) * fire_speed
	new_bullet.velocity = fire_velocity
	bullet_pool.add_child(new_bullet)
	new_bullet.global_position = global_position


func _on_timer_timeout():
	emit()
