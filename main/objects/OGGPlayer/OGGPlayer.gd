extends AudioStreamPlayer

signal pulse(beat_send)

onready var beat : int = 0

var time_begin
var time_delay
var time

var song_name : String
var sound_stream : AudioStreamOGGVorbis
var bpm : float
var offset : float 

var mspb : float 
var start_play : float

func init(song_nm : String):
	print("OGGPlayer.gd init")
	song_name = song_nm
	sound_stream = Global.music_preloads[song_name]["file"]
	bpm = Global.music_preloads[song_name]["bpm"]
	offset = Global.music_preloads[song_name]["offset"]
	mspb = 60000.0 / bpm
	start_play = 0.0

func _ready():
	print("OGGPlayer.gd ready")
	time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	
	play_sound()
#	print(Global.load_cali(song_name))
#	var song_info : Vector2 = Global.load_cali(song_name)
#	bpm = song_info.x
#	offset = song_info.y

func _process(delta):
	time = (OS.get_ticks_usec() - time_begin) / 1000000.0
	time -= time_delay
	time = max(0,time)
	if time > beat * 60.0 / bpm + 0.1:
		beat()


func beat():
	beat += 1
	emit_signal("pulse", beat)

func remove_self():
	queue_free()

func play_sound():
	set_stream(sound_stream)
	connect("finished", self, "remove_self")
	play(start_play)
