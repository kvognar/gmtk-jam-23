extends Node2D

@export var dialogue_resource: DialogueResource

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/ScoreKeeper").boss_health_changed.connect(_on_big_boss_was_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_big_boss_was_hit(health):
	if not get_node("/root/Dialog").has_been_hit:
		show_dialogue("hit")
		get_node("/root/Dialog").has_been_hit = true

func show_dialogue(key: String) -> void:
	var balloon: Node = $ColorRect2/Balloon
	balloon.start(dialogue_resource, key)
