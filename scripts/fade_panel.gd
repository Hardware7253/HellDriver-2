extends Panel

@export var game_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	game_timer.timeout.connect(_fade)

func _fade() -> void:
	get_node("AnimationPlayer").play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/end_cutscene.tscn")
