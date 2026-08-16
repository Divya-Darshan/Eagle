# "res://ui/menu/menu.tscn"
extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var open: TouchScreenButton = $open
@onready var close: TouchScreenButton = $close
@onready var reset: TouchScreenButton = $close/reset
@onready var resume: TouchScreenButton = $close/resume
@onready var start: TouchScreenButton = $"../startup/CanvasLayer/start"

func _ready() -> void:
	# Check if we triggered an auto-start restart from the pause menu
	if Engine.has_meta("auto_start"):
		Engine.remove_meta("auto_start")
		await get_tree().process_frame
		if start:
			start.pressed.emit()
			start.released.emit()


func _on_open_pressed() -> void:
	color_rect.visible = true
	close.visible = true
	open.visible = false
	get_tree().paused = true


func _on_close_pressed() -> void:
	color_rect.visible = false
	close.visible = false
	open.visible = true
	get_tree().paused = false


func _on_reset_pressed() -> void:
	# Goes back to the Main Menu (First Image)
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_resume_pressed() -> void:
	# Play/Restart gameplay button: Sets flag to auto-start, then reloads scene
	await get_tree().create_timer(0.1).timeout
	Engine.set_meta("auto_start", true)
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_github_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	OS.shell_open("https://github.com/Divya-Darshan/eagle")


func _on_leaderboard_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	OS.shell_open("https://eagle-score.onrender.com")


func _on_apk_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	OS.shell_open("https://github.com/Divya-Darshan/Eagle/raw/refs/heads/main/app/eagle.apk")
