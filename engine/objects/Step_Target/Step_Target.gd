extends Area2D

signal stepped(step)

var step = load(Global.add_obj_pth("Step"))

var target_key_press : String = "Tap" #Default that should be overridden...

func _ready():
	connect("stepped", self, "_on_Step_Target_stepped")

func _unhandled_key_input(event):
	if event.is_action_pressed(target_key_press):
		var anim = get_node("up_arrow_target/AnimationPlayer")
		if anim.is_playing():
			anim.stop()
		anim.play("pressed")
		for s in get_node("Steps_Parent").get_children():
			for area in get_overlapping_areas():
				if s == area:
					emit_signal("stepped",s)

func tick(time):
	for s in get_node("Steps_Parent").get_children():
		s.tick(time)

func pulse(time):
	for s in get_node("Steps_Parent").get_children():
		s.pulse(time)

func add_steps(steps_temp,step_index,mspb,offset):
	var beats_target = Global.split_steps(steps_temp)[step_index+1]
	var beat_map : Array = []
	for t in beats_target:
		beat_map.append(calculate_beat(t,mspb,offset))
	for beat in beat_map:
		var new_step = step.instance()
		new_step.position = Vector2( 
			self.position.x,
			Global.step_time_to_pos(
				beat,
				Profile.pxps_speed,
				self.position.y))
		new_step.set_rotation_degrees(Array([-90,0,180,90])[step_index])
		get_node("Steps_Parent").add_child(new_step)

func calculate_beat(t,mspb,offset):
	return (t - 1) * mspb / 1000 + offset


func _on_Step_Target_stepped(step):
	step.queue_free()
