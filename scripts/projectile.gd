extends Node2D

@export var velocity: Vector2 = Vector2(1000, 1000)
@export var gravity: int = 500

const DESPAWN_RADIUS = 10000

var camera: Camera2D

var has_collided = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_2d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	
func _process(delta: float) -> void:
	var pos_relative_to_camera = global_position - camera.global_position
	var camera_distance = pos_relative_to_camera.length()
	
	if camera_distance > DESPAWN_RADIUS:
		queue_free()
	
	
# Reverse projectile direction when a collision occurs
# Also make it so the projectile cannot collide again within a short period
func collision() -> void:
	if not has_collided:
		velocity *= -1
		has_collided = true
		get_node("ResetCollidedStatus").start()
		

func _on_reset_collided_status_timeout() -> void:
	has_collided = false 
