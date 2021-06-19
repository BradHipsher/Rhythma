extends Area2D

signal stepped(step)

func _unhandled_key_input(event):
	if event.is_action_pressed("Tap"):
		var anim = get_node("up_arrow_target/AnimationPlayer")
		if anim.is_playing():
			anim.stop()
		anim.play("pressed")
		for step in get_tree().get_nodes_in_group("steps"):
			for area in get_overlapping_areas():
				if step == area:
					emit_signal("stepped",step)
