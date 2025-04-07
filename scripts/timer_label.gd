extends Label


@export var game_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(int(game_timer.time_left))
	
	# Timer label needs to be hidden when the game is paused
	# because it's behind the volume icon
	if get_tree().paused:
		hide()
	else:
		show()
