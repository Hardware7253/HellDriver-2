extends Control

@export var tutorial_label: Label

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		_on_button_pressed()


func _on_audio_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
