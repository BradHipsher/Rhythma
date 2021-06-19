extends MarginContainer

func _ready():
	get_node("MenuItem/WavyText").bbcode_text = "[center][wave amp=50 freq=11.7]"+name+"[/wave][/center]"
