extends Node

## Music Preloads
var music_preloads = {
	"9mm" : {
		"file" : load(add_mus_pth("9mm")),
		"bpm" : 130.0,
		"offset" : 0.22,
		"step_map" : load_mus_dat("9mm")
	},
	
	"JazzLoop" : {
		"file" : load(add_mus_pth("JazzLoop")),
		"bpm" : 112.0,
		"offset" : 0.22,
		"step_map" : {}
	}
}

## Functionality
func change_screen(scn, delay = 1.5):
	var sd = load(add_obj_pth("Sound_Direct")).instance()
	add_child(sd)
	var sfx = load(add_sfx_pth("seventh"))
	sd.play_sound(sfx)
	yield(get_tree().create_timer(delay), "timeout")
	sd.queue_free()
	change_screen_immediate(scn)

func change_screen_immediate(scn):
	get_tree().change_scene(add_scn_pth(scn))

## I/O
func add_obj_pth(obj):
	return "res://engine/objects/"+obj+"/"+obj+".tscn"

func add_sfx_pth(sfx):
	return "res://engine/sfx/"+sfx+".ogg"

func add_scn_pth(scn) :
	return "res://main/screens/"+scn+"/"+scn+".tscn"

func add_mus_pth(mus):
	return "res://main/music/"+mus+"/"+mus+".ogg"

func add_mus_dat_pth(dat):
	return "res://main/music/"+dat+"/"+dat+".dat"

#func save_cali(song_nm : String, linest : Vector2):
#	var file = File.new()
#	file.open("res://main/music/"+song_nm+"/"+song_nm+".dat", File.WRITE)
#	file.store_string(var2str(linest))
#	file.close()
#
func load_mus_dat(dat : String):
	var file = File.new()
	file.open(add_mus_dat_pth(dat), File.READ)
	var content = {}
	for i in file.get_as_text().count(":"):
		var line = file.get_line()
		var key = float(line.split(":")[0])
		var value = int(line.split(":")[1])
#		if value.is_valid_integer():
#			value = int(value)
#		elif value.is_valid_float():
#			value = float(value)
#		elif value.begins_with("["):
#			value = value.trim_prefix("[")
#			value = value.trim_suffix("]")
#			value = value.split(",")
		content[key] = value
	file.close()
	print(content)
	return content

## STEPS
func step_time_to_pos(time : float, pxps_speed : float, y_target : float) -> float:
	return (y_target + (pxps_speed * time))

func steps_time_to_pos(times : Array, pxps_speed : float, y_target : float) -> Array:
	var poses : Array = []
	for time in times:
		poses.append(step_time_to_pos(time, pxps_speed, y_target))
	return poses

func split_steps(beats):
	var dict = { 1 : null, 2 : null, 3 : null, 4 : null}
	for dir in dict.keys():
		var beat_nums : Array = []
		for beat in beats.keys():
			if str(dir) in str(beats[beat]):
				beat_nums.append(beat)
		dict[dir] = beat_nums
	return dict

## MATHS
func range0(s : int):
	return range(s).pop_back()

func sum(arr : Array):
	var sum : float = 0.0
	for e in arr:
		sum += e
	return sum

func avg(arr : Array):
	return sum(arr) / arr.size()
	
func sumprod(arr0 : Array, arr1 : Array):
	var arr : Array = []
	var sumprod : float = 0.0
	if arr0.size() == arr1.size():
		for i in range(arr0.size()):
			arr.append(arr0[i]*arr1[i])
		sumprod = sum(arr)
	return sumprod 

func addscalar(arr0 : Array, scalar : float):
	var arr : Array = []
	for e in arr0:
		arr.append(e+scalar)
	return arr

func linest(ys : Array):
	var xs : Array = range(ys.size())
	
	var xbar : float = avg(xs)
	var ybar : float = avg(ys)
	
	var xdif : Array = addscalar(xs, -xbar)
	var ydif : Array = addscalar(ys, -ybar)
	
	var numer : float = sumprod(xdif, ydif) 
	var denom : float = sumprod(xdif, xdif)
	
	var m : float = numer / denom
	var b : float = ybar - (m * xbar)
	
	var b0 : float = b
	while (abs(b0) > abs(b0-m)):
		b0 -= m
	
	return Vector2(m, b0)
