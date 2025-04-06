extends Node2D

var camera: Camera2D

@export var velocity: Vector2

# X is the maximum random range the sprite can be offset from the right edge of the screen when repositioned
# Y is the maxium random range the sprite can be offset from the top right of the screen 
@export var reposition_offset: Vector2

var scaled_sprite_x: int

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	
	var sprite = get_node("Sprite2D")
	scaled_sprite_x = sprite.texture.get_width() * sprite.scale.x
	
func _physics_process(delta: float) -> void:
	position += velocity * delta
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var view_size = get_viewport_rect().size
	if position.x < - scaled_sprite_x:
		position = Vector2(view_size.x + 100, 0)
		position += Vector2(rng.randf(), rng.randf()) * reposition_offset
