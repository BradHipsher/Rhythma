extends Node2D

func tick(beat, time):
	get_node("TestText").text = "Beat: "+str(beat)+"; Time: "+str(time) 
