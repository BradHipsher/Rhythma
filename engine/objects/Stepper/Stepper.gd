extends Node2D

onready var beat : int = 0
onready var time : float = 0.0

var step_target = load(Global.add_obj_pth("Step_Target"))

var steps_map

var song_name = ""
var mspb = 0.0
var offset = 0.0
var time_delay = 0.0

func _ready():
	pass

func _process(delta):
	pass

func pulse(beat, time):
	print("Beat: "+str(beat)+"; Time: "+str(time))
	for step_target in get_node("Step_Targets_Parent").get_children():
		step_target.pulse(time)

func tick(beat, time):
	get_node("TestText").text = "Beat: "+str(beat)+"; Time: "+str(time)
	for step_target in get_node("Step_Targets_Parent").get_children():
		step_target.tick(time)

func set_song(song_name, mspb, off, sm):
	self.song_name = song_name
	self.mspb = mspb
	self.offset = off
	self.steps_map = sm
	for step_index in range(4):
		var new_step_target = step_target.instance()
		get_node("Step_Targets_Parent").add_child(new_step_target)
		new_step_target.target_key_press = str("target_"+str(step_index+1))
		new_step_target.position = Vector2(608 + (128 * step_index),64)
		new_step_target.set_rotation_degrees(Array([-90,0,180,90])[step_index])
		new_step_target.add_steps(steps_map,step_index,mspb,offset)
