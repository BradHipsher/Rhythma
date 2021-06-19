extends CollisionShape2D

signal clicked(nm)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("pressed!")
			emit_signal("clicked", name)
	if event.is_action_pressed("Tap"):
		print("tapped")
