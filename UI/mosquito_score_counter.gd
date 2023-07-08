extends RichTextLabel

func _ready():
	get_node("/root/ScoreKeeper").score_changed.connect(_on_score_updated)
	
func _on_score_updated(new_score):
	text = String.num_int64(new_score).pad_zeros(7)
