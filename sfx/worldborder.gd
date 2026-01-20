extends Area2D


@onready var val: AudioStreamPlayer2D = $val

func _on_body_entered(body: Node2D) -> void:
	val.play()
	get_tree().create_timer(1.0).timeout       
	get_tree().paused = true
	var menu = get_tree().get_first_node_in_group("GameMenu")
	if menu:
		menu._on_open_pressed() 
