extends Node2D

var bullet_pool: Node
var score_keeper: Node

func _ready():
	bullet_pool = get_node("/root/BulletPool")
	score_keeper = get_node("/root/ScoreKeeper")

func _on_mosquito_died():
	score_keeper.update_lives(-1)
	print_debug(score_keeper.lives)
	for child in bullet_pool.get_children():
		child.queue_free()


func _on_big_boss_was_hit():
	score_keeper.update_score(1)
	score_keeper.update_boss_health(-1)
