extends Path2D 

# Move the forcefield so it faces the mouse
func _process(delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	mouse_pos.y = -mouse_pos.y
	
	var mouse_angle = atan2(mouse_pos.y, mouse_pos.x)
	
	var path_progress = abs(mouse_angle) / PI
		
	if mouse_angle > 0:
		path_progress = abs(path_progress - 1)
		path_progress /= 2
	else:
		path_progress /= 2
		path_progress += 0.5
		
	get_node("PathFollow2D").progress_ratio = path_progress
