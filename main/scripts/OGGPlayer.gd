extends AudioStreamPlayer


var bpm : float = 130.0
var bps : float = bpm / 60
var spb : float = 1 / bps
var offset : float = 0
var beat : float = spb - offset
var beat_count : int = 0

func _ready():
	print(bpm)
	print(bps)
	print(spb)



func _process(delta):
	if (beat < 0) :
		beat += spb
		beat_count += 1
		get_node("BeatCounter").text = str(beat_count)
	else :
		beat -= delta
