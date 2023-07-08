extends Node2D

var bullet_pool: Node

func _ready():
	bullet_pool = get_node("/root/BulletPool")

func _on_mosquito_died():
	for child in bullet_pool.get_children():
		child.queue_free()
