extends VBoxContainer

var wavy_menu_item = preload("res://main/objects/Wavy_Menu_Text/Wavy_Menu_Text.tscn")

func _ready():
	var start = wavy_menu_item.instance()
	var exit = wavy_menu_item.instance()
	
	start.name = "start"
	exit.name = "exit"
		
	add_child(start)
	add_child(exit)
