extends Node
@export var road_scene: PackedScene
@export var obstacle_scene: PackedScene
@export var game_timer: Timer
var camera: Camera2D

# Size of the tileable section of the road sprite (pixels)
# You have to account for scaling manually
const TILEABLE_SPRITE_SIZE = Vector2(400, 128) * 0.97
const SPRITE_Y_RATIO = TILEABLE_SPRITE_SIZE.y / TILEABLE_SPRITE_SIZE.x
const ROAD_SPEED = 800
const ROAD_VELOCITY = Vector2(-ROAD_SPEED, -ROAD_SPEED * SPRITE_Y_RATIO)

var INIT_ROAD_SPAWN_POS = Vector2(0.0, 0.0)
var last_road_pos: Vector2

# Size of the default viewport
var canvas_size: Vector2

# Number of pixels between the offscreen road and the camera
var ROAD_EDGE_PAD = 1000.0

# Range of times in seconds between obstacles being spawned
@export var obstacle_timer_min = 4
@export var obstacle_timer_max = 8

# The obstacle timer min and max times will be subtracted by
# this number at maximum difficulty
@export var obstacle_timer_difficulty_offset = 2.5

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var height = ProjectSettings.get_setting("display/window/size/viewport_width")
	canvas_size = Vector2(width, height)
	
	camera = get_viewport().get_camera_2d()
	
	# Initialise last_road_spawn_pos
	last_road_pos = INIT_ROAD_SPAWN_POS - TILEABLE_SPRITE_SIZE 
	var roads_needed = (canvas_size.x + ROAD_EDGE_PAD) / TILEABLE_SPRITE_SIZE.x
	for i in range(0, int(roads_needed + 1)):
		spawn(road_scene, true)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	last_road_pos += ROAD_VELOCITY * delta
	if (camera.global_position.x + canvas_size.x) > (last_road_pos.x - ROAD_EDGE_PAD):
		spawn(road_scene, true)

# Spawns an instance of the moving object and gives it velocity
func spawn(scene: PackedScene, update_last_pos: bool):
	var road_spawn_position = last_road_pos + TILEABLE_SPRITE_SIZE
	
	var road_instance = scene.instantiate()
	add_child(road_instance)
	road_instance.position = road_spawn_position
	road_instance.velocity = ROAD_VELOCITY
	
	if update_last_pos:
		last_road_pos = road_spawn_position
	

func _on_timer_timeout() -> void:
	var difficulty_offset = (obstacle_timer_difficulty_offset * game_timer.progress)
	var min_time = obstacle_timer_min - difficulty_offset
	var max_time = obstacle_timer_max - difficulty_offset
	
	var new_wait_time = rng.randf_range(min_time, max_time)
	get_node("Timer").wait_time = new_wait_time
	spawn(obstacle_scene, false)
