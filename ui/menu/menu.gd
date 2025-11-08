extends CanvasLayer


@onready var color_rect: ColorRect = $ColorRect
@onready var open: TouchScreenButton = $open
@onready var close: TouchScreenButton = $close
@onready var coin: Node = $"../coin"

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
	coin.reset_coins()


func _on_touch_screen_button_pressed() -> void:
	OS.shell_open("https://github.com/Divya-Darshan/eagle")
