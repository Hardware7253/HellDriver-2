extends Timer

var progress = 0

signal game_over
var is_game_over = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress = (wait_time - time_left) / wait_time
	
	
	if time_left == 0 and !is_game_over:
		get_tree().paused = true
		game_over.emit()
		is_game_over = true
		
		

		
