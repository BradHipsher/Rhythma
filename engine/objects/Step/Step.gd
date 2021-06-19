extends Area2D

var starting_x
var move_rate = Global.pxps_speed # px/s


func _ready():
	starting_x = position.x

func tick(time):
	position.x = starting_x - (time * move_rate)

