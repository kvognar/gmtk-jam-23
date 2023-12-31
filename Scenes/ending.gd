extends Node2D

@export var Balloon: PackedScene
@export var title: String = "end"
@export var dialogue_resource: DialogueResource

signal change_to_scene(new_scene: PackedScene)

func _ready():
	await get_tree().create_timer(0.4).timeout
	var random = RandomNumberGenerator.new()
	random.randomize()
	var r = random.randi_range(1, 2)
	show_dialogue(title + "_" + str(r))


func show_dialogue(key: String) -> void:
	assert(dialogue_resource != null, "\"dialogue_resource\" property needs a to point to a DialogueResource.")
	
	var balloon: Node = $Balloon
	balloon.start(dialogue_resource, key)
	balloon.dialog_ended.connect(_on_dialog_end)

func _on_dialog_end() -> void:
	change_to_scene.emit(load("res://UI/title_screen.tscn"))
