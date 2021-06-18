extends AudioStreamPlayer

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
#	print(Global.load_cali(song_name))
#	var song_info : Vector2 = Global.load_cali(song_name)
#	bpm = song_info.x
#	offset = song_info.y

func remove_self():
	queue_free()

func play_sound():
	set_stream(sound_stream)
	connect("finished", self, "remove_self")
	play(start_play)
