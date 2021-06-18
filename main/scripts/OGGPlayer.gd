extends AudioStreamPlayer

var song_name : String
var sound_stream : AudioStreamOGGVorbis

var bpm : float 
var mspb : float 
var offset : float
var start_play : float = 0.0

const sound_stream_path = Global.music_preloads["9mm"] #Try to figure out how to generalize this...

func init(song_nm : String):
	song_name = song_nm

func _ready():
	print(Global.load_cali(song_name))
	var song_info : Vector2 = Global.load_cali(song_name)
	bpm = song_info.x
	offset = song_info.y
	sound_stream = preload(sound_stream_path)

func remove_self():
	queue_free()

func play_sound():
	set_stream(sound_stream)
	connect("finished", self, "remove_self")
	play(start_play)
