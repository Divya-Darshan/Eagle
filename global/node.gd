extends Node

var val: float = 0.0   # make it a float

@onready var label: Label = $CanvasLayer/Label

func _ready() -> void:
	if label == null:
		push_error("❌ Label not found! Check node path.")
	else:
		label.text = str(val)
		print("✅ Label connected successfully")

func add_coin() -> void:
	val += 0.5
	if label:
		label.text = str(val)
	print("Coins:", val)
