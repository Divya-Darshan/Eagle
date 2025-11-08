extends Area2D

@onready var val: AudioStreamPlayer2D = $val

func _on_body_entered(body: Node2D) -> void:
	val.play()     
	get_tree().paused = true
