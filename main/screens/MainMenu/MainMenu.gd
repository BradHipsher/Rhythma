extends Node2D

var sound 
var sound_direct = preload("res://main/objects/OGGPlayer/OGGPlayer.tscn")

var song_name : String = "JazzLoop"

onready var time_presses = []

func _ready():
	print("mainmenu ready")
	get_node("MenuItems").conn()
	sound = sound_direct.instance()
	sound.init(song_name)
	add_child(sound)
	sound.connect("pulse", self, "_on_OGGPlayer_pulse")
	print("sound.bpm: " + str(sound.bpm))

func _on_OGGPlayer_pulse(beat_send):
	get_node("PanelContainer/AnimationPlayer").play("pulse")
	print(str(beat_send))

func _on_Wavy_Menu_Text_clicked(nm):
	print(nm)

func start_game():
	print("start game")

func exit_game():
	print("exit game")

#func _unhandled_key_input(event):
#	if event.is_action_pressed("Tap"):
#		time_presses.append(time)
#	if event.is_action_pressed("Escape"):
#		Global.save_cali("9mm",Global.linest(time_presses))
#		get_tree().quit()
