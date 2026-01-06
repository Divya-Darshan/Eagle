# "res://Tiles/pole.tscn"
extends Area2D

@onready var ahhh: AudioStreamPlayer2D = $ahhh
@onready var poll: Area2D = $"."



func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	poll.queue_free()

func _on_body_entered(body: Node2D) -> void:
	ahhh.play()
	print('game paused')
	get_tree().create_timer(1.0).timeout      
	get_tree().paused = true    
	var menu = get_tree().get_first_node_in_group("GameMenu")
	if menu:
		menu._on_open_pressed()                                                                   

func _on_coin_adder_body_entered(body: Node2D) -> void:
	Score.add_coin()
