extends Node2D

@onready var startup: Node2D = $startup
@onready var dead: AudioStreamPlayer2D = $CharacterBody2D/dead
@onready var pole_scene := preload("res://Tiles/pole.tscn")
@onready var camera_2d: Camera2D = $CharacterBody2D/Camera2D
const START_GAP_SIZE := 460       # initial vertical gap
const MIN_GAP_SIZE := 600         # minimum gap (hardest difficulty)
const PIPE_SPEED := -100.0        # move left speed
const SPAWN_INTERVAL := 1.6       # seconds between spawns
const SPAWN_OFFSET_X := 500       # how far in front of camera pipes appear
const MARGIN := 500

var game_tick := 1.0                # margin so pipes never touch the screen edges

@onready var st: Label = $startup/CanvasLayer/start/Label
@onready var ab: Label = $startup/CanvasLayer/about/Label


var spawn_timer: float = 0.0
var time_elapsed: float = 0.0

func _process(delta: float) -> void:
	game_tick += 0.00004
	Engine.time_scale = game_tick

	
	if $menu/close/resume.is_pressed():
		game_tick = 1.0
	
	spawn_timer -= delta
	time_elapsed += delta
	if spawn_timer <= 0.0:
		spawn_pipe_pair()
		spawn_timer = SPAWN_INTERVAL
		



func spawn_pipe_pair() -> void:
	# Camera details
	var cam_pos = camera_2d.get_screen_center_position()
	var viewport_height = get_viewport().get_visible_rect().size.y

	# Gradually reduce the gap size to make the game harder
	var difficulty_factor = clamp(time_elapsed / 60.0, 0.0, 1.0) # after ~1 min it’s hardest
	var gap_size = lerp(START_GAP_SIZE, MIN_GAP_SIZE, difficulty_factor)

	# Allowed Y range for gap center (keeps gap inside camera view)
	var min_center = cam_pos.y - viewport_height / 2 + gap_size / 2 + MARGIN
	var max_center = cam_pos.y + viewport_height / 2 - gap_size / 2 - MARGIN
	var gap_center_y = randf_range(min_center, max_center)

	# X position where pipes spawn
	var spawn_x = cam_pos.x + SPAWN_OFFSET_X

	# --- Top Pipe ---
	var top_pipe = pole_scene.instantiate()
	add_child(top_pipe)
	top_pipe.global_position = Vector2(spawn_x, gap_center_y - gap_size / 2)
	top_pipe.scale.y = -1
	top_pipe.set("velocity", Vector2(PIPE_SPEED, 0))

	# --- Bottom Pipe ---
	var bottom_pipe = pole_scene.instantiate()
	add_child(bottom_pipe)
	bottom_pipe.global_position = Vector2(spawn_x, gap_center_y + gap_size / 2)
	bottom_pipe.set("velocity", Vector2(PIPE_SPEED, 0))

func _ready() -> void:
	get_tree().paused = true
	$menu/open.visible = false

func _on_start_pressed() -> void:
	$menu/open.visible = true
	get_tree().paused = false
	startup.queue_free()


func _on_about_pressed() -> void:
	game_tick = 1.0
