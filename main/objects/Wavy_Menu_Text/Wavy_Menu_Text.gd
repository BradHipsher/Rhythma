extends MarginContainer

func _ready():
	get_node("NormalText").bbcode_text = "[center][wave amp=50 freq=11.7]"+name+"[/wave][/center]"
	get_node("HoverText").bbcode_text = "[center][color=yellow][wave amp=50 freq=11.7]"+name+"[/wave][/color][/center]"
	get_node("HoverText").visible = false

func _on_Button_mouse_entered():
	get_node("HoverText").visible = true


func _on_Button_mouse_exited():
	get_node("HoverText").visible = false
