extends CanvasLayer

var sound 
var sound_direct = preload("res://main/objects/OGGPlayer/OGGPlayer.tscn")

var song_name : String = "9mm"

onready var time_presses = []

func _ready():
	print("mainmenu ready")
	sound = sound_direct.instance()
	sound.init(song_name)
	add_child(sound)
	sound.connect("pulse", self, "_on_OGGPlayer_pulse")
	sound.connect("tick",self, "on_OGGPlayer_tick")
	print("sound.bpm: " + str(sound.bpm))

func _on_OGGPlayer_pulse(beat_send):
	pass

func on_OGGPlayer_tick(beat_send, time_send):
	get_node("Stepper").tick(beat_send, time_send)


#func _unhandled_key_input(event):
#	if event.is_action_pressed("Tap"):
#		time_presses.append(time)
#	if event.is_action_pressed("Escape"):
#		Global.save_cali("9mm",Global.linest(time_presses))
#		get_tree().quit()
