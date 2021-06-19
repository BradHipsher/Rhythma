extends Node2D

onready var beat : int = 0
onready var time : float = 0.0

var step = load(Global.add_obj_pth("Step"))

var steps_temp = [
	21.0, 22.0, 23.0, 24.0, 
	25.0, 26.0, 27.0, 28.0,
	29.0, 29.5, 30.0, 31.0, 31.5, 32.0
]

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
	for t in steps_temp:
		beat_map.append(calculate_beat(t))
	print(beat_map)
	for beat in beat_map:
		var new_step = step.instance()
		new_step.position = Vector2(
			Global.step_time_to_pos(
				beat,
				Global.pxps_speed,
				get_node("Step_Target").position.x), 
			get_node("Step_Target").position.y)
		add_child(new_step)

func _on_Step_Target_stepped(step):
	step.queue_free()

func calculate_beat(t):
	return (t - 1) * mspb / 1000 + offset
