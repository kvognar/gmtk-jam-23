extends Node

const MAX_LIVES = 3
var lives = MAX_LIVES
var current_phase = 1
var score = 0

var boss_health = 10000

signal lives_changed(new_lives: int)
signal score_changed(new_score: int)
signal boss_health_changed(new_health: int)

func update_score(delta):
	score += delta
	score_changed.emit(score)

func update_lives(delta):
	lives += delta
	lives_changed.emit(lives)

func update_boss_health(delta):
	boss_health += delta
	boss_health_changed.emit(boss_health)
