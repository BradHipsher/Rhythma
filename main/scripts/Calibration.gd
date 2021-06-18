extends Node2D

var song = preload("res://main/Music/9mm/9mm.ogg")
var sound_direct = preload("res://main/objects/OGGPlayer.tscn")

onready var sumDeltaK : float = 0
onready var deltaK : float = 0
onready var sumDeltaKs = []

func _ready():
	var sound = sound_direct.instance()
	add_child(sound)
	sound.play_sound(song)
	print(Global.load_cali())

func _process(delta):
	deltaK = delta * 1000
	sumDeltaK += deltaK

func _unhandled_key_input(event):
	if event.is_action_pressed("Tap"):
		sumDeltaKs.append(sumDeltaK)
	if event.is_action_pressed("Escape"):
		Global.save_cali(Global.linest(sumDeltaKs))
		get_tree().quit()
