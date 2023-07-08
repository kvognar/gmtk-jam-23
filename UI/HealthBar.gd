extends TextureProgressBar

func _ready():
	get_node("/root/ScoreKeeper").boss_health_changed.connect(_on_health_changed)

func _on_health_changed(new_health):
	value = new_health
