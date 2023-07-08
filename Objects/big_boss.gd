extends Area2D

var hp = 10000

signal was_hit()

func _on_area_entered(area):
	area.queue_free()
	hp -= 1
	was_hit.emit()
