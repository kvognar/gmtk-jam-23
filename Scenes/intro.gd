extends Node2D

@export var Balloon: PackedScene
@export var title: String = "start"
@export var dialogue_resource: DialogueResource

func _ready():
	await get_tree().create_timer(0.4).timeout
	show_dialogue(title)


func show_dialogue(key: String) -> void:
	assert(dialogue_resource != null, "\"dialogue_resource\" property needs a to point to a DialogueResource.")
	
	var balloon: Node = Balloon.instantiate()
	add_child(balloon)
	balloon.start(dialogue_resource, key)
	balloon.dialog_ended.connect(_on_dialog_end)

func _on_dialog_end() -> void:
	get_tree().change_scene_to_file("res://UI/ui.tscn")
