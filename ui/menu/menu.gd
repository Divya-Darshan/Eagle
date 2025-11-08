extends CanvasLayer


@onready var color_rect: ColorRect = $ColorRect
@onready var open: TouchScreenButton = $open
@onready var close: TouchScreenButton = $close


func _on_open_pressed() -> void:
	color_rect.visible = true
	close.visible = true
	open.visible = false
	get_tree().paused = true   # now UI WON'T freeze because this layer is autoload

func _on_close_pressed() -> void:
	color_rect.visible = false
	close.visible = false
	open.visible = true
	get_tree().paused = false


func _on_reset_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()



func _on_touch_screen_button_pressed() -> void:
	OS.shell_open("https://github.com/Divya-Darshan/eagle")


func _on_resume_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	color_rect.visible = false
	close.visible = false
	open.visible = true
	get_tree().paused = false
