extends CanvasLayer

var sound 
var sound_direct = preload("res://engine/objects/OGGPlayer/OGGPlayer.tscn")

var song_name : String = "JazzLoop"

onready var time_presses = []

func _ready():
	sound = sound_direct.instance()
	sound.init(song_name)
	add_child(sound)
	sound.connect("pulse", self, "_on_OGGPlayer_pulse")
	print("sound.bpm: " + str(sound.bpm))
	register_buttons()

func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		button.connect("pressed", self, "_on_button_pressed", [button.get_parent().name])

func _on_button_pressed(name):
	match name:
		"start":
			sound.queue_free()
			Global.change_screen("Sandbox")
		"exit":
			pass

func _on_OGGPlayer_pulse(beat_send, time):
	get_node("PulsingBkgd/AnimationPlayer").play("pulse")

func _on_Wavy_Menu_Text_clicked(nm):
	pass

func start_game():
	pass

func exit_game():
	pass

#func _unhandled_key_input(event):
#	if event.is_action_pressed("Tap"):
#		time_presses.append(time)
#	if event.is_action_pressed("Escape"):
#		Global.save_cali("9mm",Global.linest(time_presses))
#		get_tree().quit()
