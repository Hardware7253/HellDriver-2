extends AnimatedSprite2D

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.decrease_health.connect(_decrease_health)
	
func _decrease_health() -> void:
	frame += 1
