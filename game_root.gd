extends Node2D

var next_scene: PackedScene

func _change_to_scene(new_scene: PackedScene):
	next_scene = new_scene
	$Curtain.show()
	$Curtain/CurtainAnimationPlayer.play("Fade Out")

func _on_curtain_animation_player_animation_finished(anim_name):
	if anim_name == "Fade Out":
		var new_scene = next_scene.instantiate()
		for child in $SceneContainer.get_children():
			child.queue_free()
		$SceneContainer.add_child(new_scene)
		$Curtain/CurtainAnimationPlayer.play("Fade In")
		if new_scene.has_signal("change_to_scene"):
			new_scene.change_to_scene.connect(_change_to_scene)
	if anim_name == "Fade In":
		$Curtain.hide()
		

