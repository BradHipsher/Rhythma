extends Node2D

onready var beat : int = 0
onready var time : float = 0.0

var step = load(Global.add_obj_pth("Step"))

var steps_temp = {
	21.0 : "U", 22.0 : "U", 23.0 : "U", 24.0 : "U", 
	25.0 : "U", 26.0 : "U", 27.0 : "U", 28.0 : "U",
	29.0 : "U", 29.5 : "U", 30.0 : "U", 31.0 : "U", 31.5 : "U", 32.0 : "U"
}

var song_name = ""
var mspb = 0.0
var offset = 0.0
var time_delay = 0.0

var beat_map : Array = []

func _ready():
	get_node("Step_Target").connect("stepped", self, "_on_Step_Target_stepped")

func _process(delta):
	pass

func pulse(beat, time):
	print("Beat: "+str(beat)+"; Time: "+str(time))

func tick(beat, time):
	get_node("TestText").text = "Beat: "+str(beat)+"; Time: "+str(time)
	for step in get_tree().get_nodes_in_group("steps"):
		step.tick(time)

func set_song(song_name, mspb, off):
	print("setting song")
	self.song_name = song_name
	self.mspb = mspb
	self.offset = off
	var beats_up = Global.split_steps(steps_temp)["U"]
	for t in beats_up:
		beat_map.append(calculate_beat(t))
	print(beat_map)
	for beat in beat_map:
		var new_step = step.instance()
		new_step.position = Vector2( 
			get_node("Step_Target").position.x,
			Global.step_time_to_pos(
				beat,
				Profile.pxps_speed,
				get_node("Step_Target").position.y))
		add_child(new_step)

func _on_Step_Target_stepped(step):
	step.queue_free()

func calculate_beat(t):
	return (t - 1) * mspb / 1000 + offset
