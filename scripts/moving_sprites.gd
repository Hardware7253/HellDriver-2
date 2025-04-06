extends StaticBody2D

var camera: Camera2D

# Supposed to be set by the parent
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	
func _physics_process(delta: float) -> void:
	position += velocity * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x < (camera.global_position.x - get_viewport_rect().size.x):
		queue_free()
	
