extends Node

var val: int = 0

@onready var label: Label = $CanvasLayer/Label

func _ready() -> void:
	if label == null:
		push_error("❌ Label not found! Check node path.")
	else:
		label.text = str(val)
		print("✅ Label connected successfully")

func add_coin() -> void:
	val += 1
	if label:
	
		label.text = str(val)   # UI updates here
	print("Coins:", val)        # Console updates here
