extends Node2D

@export var star_count = 100

func _ready():
	var star_scene = load("res://Objects/star.tscn")
	for i in star_count:
		var star = star_scene.instantiate()
		add_child(star)
