extends Area2D

var starting_y
var move_rate = Profile.pxps_speed # px/s


func _ready():
	starting_y = position.y

func tick(time):
	position.y = starting_y - (time * move_rate)

func pulse(time):
	pass
