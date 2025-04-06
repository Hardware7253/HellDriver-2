extends Node2D

@export var projectile: PackedScene
@export var player: CharacterBody2D
@export var projectile_container: Node
@export var game_timer: Timer
var camera: Camera2D

var rng = RandomNumberGenerator.new()
var total_time = 0
const PROJECTILE_SPEED = 800
const PROJECTILE_VELOCITY = Vector2(PROJECTILE_SPEED, PROJECTILE_SPEED)

# How often to spawn projectiles based off difficulty
@export var projectile_timer_difficult = 0.05
@export var projectile_timer_easy = 0.09
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_2d()

func spawn_projectile() -> void:
	var viewport_size = get_viewport_rect().size + Vector2(500, 500)
	
	# Get spawn position multiplier
	var spawn_region = rng.randf()
	var spawn_position: Vector2
	if spawn_region < 0.2:
		spawn_position = Vector2(rng.randf(), 0) # Top
	elif spawn_region < 0.4:
		spawn_position = Vector2(rng.randf(), 1) # Bottom
	elif spawn_region < 0.7:
		spawn_position = Vector2(0, rng.randf()) # Left
	else:
		spawn_position = Vector2(1, rng.randf()) # Right
	
	# Determine the projectiles spawn position (at one of the screen edges)
	spawn_position = viewport_size * spawn_position
	spawn_position += global_position - viewport_size / 2
	
	var direction = Vector2(rng.randf() * 2 - 1, rng.randf() * 2 - 1).normalized()
	var projectile_velocity = PROJECTILE_VELOCITY * direction
	
	# Particles must be spawned wrt the root
	# Otherwise they will jump when the player jumps
	var projectile_instance = projectile.instantiate()
	projectile_container.add_child(projectile_instance)
	
	projectile_instance.position = spawn_position
	projectile_instance.velocity = projectile_velocity
	
func _physics_process(delta: float) -> void:
	var camera_pos = camera.global_position
	position = camera_pos
	total_time += delta
	
# Spawn obstacle when obstacle timer is done
# Also increase the difficulty over time
func _on_timer_timeout() -> void:
	var difficulty_offset = projectile_timer_easy - projectile_timer_difficult
	var new_wait_time = projectile_timer_easy - difficulty_offset * game_timer.progress
	#print(Vector2(new_wait_time, game_timer.progress))
	get_node("Timer").wait_time = new_wait_time
	spawn_projectile()
