extends Node2D

@export var dialogue_resource: DialogueResource
var balloon: Node

signal change_to_scene(new_scene: PackedScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	balloon = $ColorRect2/Balloon
	get_node("/root/ScoreKeeper").boss_health_changed.connect(_on_big_boss_was_hit)
	get_node("/root/ScoreKeeper").lives_changed.connect(_on_lives_changed)
	$GameOverScreen.end_game.connect(_on_game_end)
	balloon.dialog_ended.connect(_on_dialog_end)

func _on_dialog_end() -> void:
	get_node("/root/Dialog").in_dialog = false
	await get_tree().create_timer(5).timeout
	get_node("/root/Dialog").recently_displayed = false
	
func _on_lives_changed(lives):
	if lives == 2:
		show_dialogue("mosquito_death_1", true)
	elif lives == 1:
		show_dialogue("mosquito_death_2", true)
	elif lives == 0:
		show_dialogue("mosquito_death_3", true)

func _on_big_boss_was_hit(health):
	if not get_node("/root/Dialog").recently_displayed:
		var health_percentage = ((health * 100) / get_node("/root/ScoreKeeper").MAX_HEALTH)
		if health_percentage > 60:
			show_dialogue("doing_well")
		elif health_percentage > 30:
			show_dialogue("doing_poorly")
		else:
			show_dialogue("taking_significant_damage")
		get_node("/root/Dialog").has_been_hit = true
		
func _on_game_end():
	change_to_scene.emit(load("res://Scenes/ending.tscn"))

func show_dialogue(key: String, interrupt: bool = false) -> void:
	if interrupt or get_node("/root/Dialog").in_dialog == false:
		get_node("/root/Dialog").in_dialog = true
		get_node("/root/Dialog").recently_displayed = true
		balloon.start(dialogue_resource, key)
