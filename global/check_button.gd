extends Control

@onready var check_button: CheckButton = $CheckButton
@onready var goon: TouchScreenButton = $goon
@onready var goon_2: TouchScreenButton = $goon2
@onready var is_pressed_goon := false

func _on_goon_pressed() -> void:
	is_pressed_goon = true
	goon_2.visible = true
	goon.visible = false
	check_button.set_pressed(true)
	print("✅ checked")

func _on_goon_2_pressed() -> void:
	is_pressed_goon = false
	goon_2.visible = false
	goon.visible = true
	check_button.set_pressed(false)
	print("✅ unchecked")
