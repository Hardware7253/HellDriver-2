extends CharacterBody2D

const JUMP_VELOCITY = -400.0

@export var projectile_container: Node
@export var hit_sound: AudioStreamPlayer2D
@export var rebound_sound: AudioStreamPlayer2D

const MAX_HEALTH = 8
signal decrease_health

func _ready() -> void:
	Health.health = MAX_HEALTH

# To adjust how much the player bounces from the road adjust the snap length (floor settings)
func _physics_process(delta: float) -> void:
	  
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
	
	# Rotate the player
	if is_on_floor():
		rotation = get_floor_angle()
	
# Redirect projectiles that hit the force field
func _on_force_field_body_entered(body: Node2D) -> void:
	rebound(body)
	rebound_sound.playing = true


func _on_hit_detector_body_entered(body: Node2D) -> void:
	Health.health -= 1
	decrease_health.emit()
	
	if body.collision_layer == 2: # Reverse projectile direction
		rebound(body)
	else:
		velocity.y = JUMP_VELOCITY / 4
	
	hit_sound.playing = true

# For rebounding projectiles
func rebound(body: Node2D) -> void:
	var projectile = body.get_parent()
	projectile.collision()
	
