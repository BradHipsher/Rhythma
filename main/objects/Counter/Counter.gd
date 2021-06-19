extends Label



onready var beat : int = 0

func beat():
	beat += 1
	text = "Beat: " + str(beat)
	emit_signal("pulse")
