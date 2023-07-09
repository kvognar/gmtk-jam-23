extends Node2D

var bullet_pool: Node
var score_keeper: Node
var mosquito: CharacterBody2D

var mosquito_types = [load("res://Objects/mosquito_medium.tscn"), load("res://Objects/mosquito_small.tscn")]

func _ready():
	bullet_pool = get_node("/root/BulletPool")
	score_keeper = get_node("/root/ScoreKeeper")
	mosquito = $Mosquito

func _on_mosquito_died():
	score_keeper.update_lives(-1)
	for child in bullet_pool.get_children():
		child.queue_free()
		
	if score_keeper.lives < 1:
		score_keeper.update_lives(score_keeper.MAX_LIVES)
		var respawn_point = mosquito.respawn_point
		var next_mosquito_type = mosquito_types.pop_front()
		if !next_mosquito_type:
			return
		mosquito.queue_free()
		mosquito = next_mosquito_type.instantiate()
		add_child(mosquito)
		mosquito.set_deferred("respawn_point", respawn_point)
		mosquito.call_deferred("respawn")
		mosquito.died.connect(_on_mosquito_died)
		

func _on_big_boss_was_hit():
	score_keeper.update_score(1)
	score_keeper.update_boss_health(-1)
