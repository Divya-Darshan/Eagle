extends Camera2D

@export var target: NodePath          # Drag your Player node here
@export var smooth_speed: float = 10000000.0 # Higher = snappier, lower = smoother

var target_node: Node2D

func _ready():
	if target != NodePath():
		target_node = get_node(target)

func _process(delta):
	if target_node:
		# Smooth interpolation
		global_position = lerp(
			global_position,
			target_node.global_position,
			delta * smooth_speed
		)
