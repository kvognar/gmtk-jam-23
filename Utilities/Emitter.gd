extends Node2D

var bullet_type: PackedScene
@export var fire_speed: int
@export var fire_angle: float

func _ready():
	bullet_type = load("res://Objects/bullet.tscn")
	
func _process(delta):
	fire_angle += 1.0 * delta

func emit():
	var new_bullet = bullet_type.instantiate()
	var fire_velocity = Vector2.from_angle(fire_angle) * fire_speed
	new_bullet.velocity = fire_velocity
	$Objects.add_child(new_bullet)


func _on_timer_timeout():
	emit()
