extends Node2D

var time_begin
var time_delay
var time

var beat : int = 0

var sound 
var sound_direct = preload("res://main/objects/OGGPlayer.tscn")

var song_name : String = "9mm"

onready var time_presses = []

func _ready():
	print("Calibration.gd ready")
	sound = sound_direct.instance()
	sound.init(song_name)
	add_child(sound)
	
	time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	
	sound.play_sound()
	
	print("sound.bpm: " + str(sound.bpm))

func _process(delta):
	time = (OS.get_ticks_usec() - time_begin) / 1000000.0
	time -= time_delay
	time = max(0,time)
	if time > beat * 60.0 / sound.bpm + 0.1:
		beat += 1
		get_node("Counter").text = str(beat)

func _unhandled_key_input(event):
	if event.is_action_pressed("Tap"):
		time_presses.append(time)
	if event.is_action_pressed("Escape"):
		Global.save_cali("9mm",Global.linest(time_presses))
		get_tree().quit()
