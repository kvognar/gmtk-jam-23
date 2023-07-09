extends Area2D

@export var velocity: Vector2 = Vector2.ZERO

func _init():
	pass

func _physics_process(delta):
	position = position + (velocity * delta)
	


func _on_timer_timeout():
	queue_free()
