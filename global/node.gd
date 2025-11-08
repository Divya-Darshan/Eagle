extends Node

var val: float = 0.0
@onready var label: Label = $CanvasLayer/Label
const SAVE_PATH := "user://coins.save"

func _ready():
	load_data()
	if label:
		label.text = str(val)

func add_coin() -> void:
	val += 0.5
	save_data()
	if label:
		label.text = str(val)
	print("Coins:", val)

func reset():
	val = 0.0
	save_data()
	if label:
		label.text = str(val)

func save_data():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(val)
	print("✅ Saved:", val)

func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		val = file.get_var()
		print("✅ Loaded:", val)
	else:
		print("⚠ No previous save found.")
