extends CanvasLayer

var sound 
var sound_direct = preload("res://engine/objects/OGGPlayer/OGGPlayer.tscn")

var song_name : String = "9mm"

onready var time_presses = []

func _ready():
	sound = sound_direct.instance()
	sound.init(song_name)
	sound.connect("pulse", self, "_on_OGGPlayer_pulse")
	sound.connect("tick",self, "_on_OGGPlayer_tick")
	sound.connect("track_info", self, "_on_OGGPlayer_track_signal")
	add_child(sound)
	print("sound.bpm: " + str(sound.bpm))

func _on_OGGPlayer_pulse(beat_send, time_send):
	get_node("Stepper").pulse(beat_send, time_send)

func _on_OGGPlayer_tick(beat_send, time_send):
	get_node("Stepper").tick(beat_send, time_send)

func _on_OGGPlayer_track_signal(song_name, mspb, off, sm):
	get_node("Stepper").set_song(song_name, mspb, off, sm)

func _unhandled_key_input(event):
	if event.is_action_pressed("Escape"):
		Global.change_screen_immediate("MainMenu")
