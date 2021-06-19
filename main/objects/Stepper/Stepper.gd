extends Node2D

onready var beat : int = 0
onready var time : int = 0

func tick(beat, time):
	get_node("TestText").text = "Beat: "+str(beat)+"; Time: "+str(time) 
