extends Control

@export var tutorial_label: Label

func _on_audio_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
