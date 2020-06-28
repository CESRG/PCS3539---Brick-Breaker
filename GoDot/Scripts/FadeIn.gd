extends ColorRect


signal _fade_in_finished

func fade_in():
	$AnimationPlayer.play("fade_in")



func _on_AnimationPlayer_animation_finished(anim_name):
	print("Finished")
	emit_signal("_fade_in_finished")
