extends Area2D

var hp = 10000



func _on_area_entered(area):
	area.queue_free()
	hp -= 1
