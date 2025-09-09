extends Area2D

@onready var rect: ColorRect = $rect
@onready var val: AudioStreamPlayer2D = $val

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	get_tree().paused = true                                                                            
	val.play()



func _on_area_2d_body_entered(body: Node2D) -> void:
	Score.add_coin()


func _on_val_finished() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
