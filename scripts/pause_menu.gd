extends Control

@export var game_timer: Timer

func _process(delta: float) -> void:
	
	# Prevent the pause menu from working during the end cutscene
	if game_timer.time_left == 0:
		return
	
	var is_paused = get_tree().paused
	if Input.is_action_just_pressed("ui_cancel"):
		if is_paused:
			_on_resume_pressed()
		else:
			get_tree().paused = true
			self.show()

func _on_ready() -> void:
	self.hide()


func _on_menu_pressed() -> void:
	_on_resume_pressed()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_restart_pressed() -> void:
	_on_resume_pressed()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	


func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.hide()
