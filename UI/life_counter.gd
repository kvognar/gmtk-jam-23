extends RichTextLabel

func _ready():
	get_node("/root/ScoreKeeper").lives_changed.connect(_on_lives_updated)
	
func _on_lives_updated(new_lives):
	text = String.num_int64(new_lives)
