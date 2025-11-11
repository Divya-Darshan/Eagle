extends Node

var val: float = 0.0
@onready var label: Label = $CanvasLayer/sprite/Label
const SAVE_PATH := "user://coins.save"
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var close: TouchScreenButton = $CanvasLayer/close





func _ready():

	load_data()
	update_label()
	label.text = ""
	
	

func add_coin() -> void:
	val += 0.5
	save_data()
	update_label()
	#print("Coins:", val) #prints conin value

func update_label():
	if val > 0:
		label.text = str(val)
	else:
		label.text = ""


func save_data():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(val)

func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		var loaded = file.get_var()
		val = float(loaded)
	else:
		val = 0.0

func reset_coins():
	val = 0.0
	save_data()
	update_label()
