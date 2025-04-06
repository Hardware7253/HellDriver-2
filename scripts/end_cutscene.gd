extends Control


@export var good_ending_voiceline: AudioStreamPlayer
@export var middle_ending_voiceline: AudioStreamPlayer
@export var bad_ending_voiceline: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = Health.health
	health = 8
	
	var voiceline: AudioStreamPlayer
	var subtitle: String
	if health > 5:
		voiceline = good_ending_voiceline
		subtitle = "Thank you my loyal imp for bringing me this pizza."
	elif health > 3:
		voiceline = middle_ending_voiceline
		subtitle = "This is of acceptable quality."
	else:
		voiceline = bad_ending_voiceline
		subtitle = "Hm. Try harder next time."
	voiceline.playing = true
	
	get_node("MarginContainer/Label").text = subtitle

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_timer_timeout() -> void:
	get_node("MarginContainer/Label").visible = false
