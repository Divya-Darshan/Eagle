extends Area2D

@onready var val: AudioStreamPlayer2D = $val
@onready var poll: Area2D = $"."

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	poll.queue_free()

func _on_body_entered(body: Node2D) -> void:
	print('game paused')
	get_tree().paused = true                                                                          

func _on_coin_adder_body_entered(body: Node2D) -> void:
	Score.add_coin()
