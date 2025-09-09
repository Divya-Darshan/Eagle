extends Node

var val: float = 0.0   # make it a float
@onready var label: Label = $CanvasLayer/Label

func add_coin() -> void:
	val += 0.5
	if label:
		label.text = str(val)
	print("Coins:", val)

func reset():
	val = 0.0
