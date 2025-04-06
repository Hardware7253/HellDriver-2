extends Camera2D

@export var player: Node2D

# Offset camera y position 
var CAMERA_Y_OFFSET = 00

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = Vector2(player.position.x, player.position.y + CAMERA_Y_OFFSET)
