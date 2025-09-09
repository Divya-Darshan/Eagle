extends CharacterBody2D
 
const GRAVITY: float = 1000.0      # Pulls bird down
const FLAP_STRENGTH: float = -350.0 # Upward force when tapping
const FORWARD_SPEED: float = 200.0  # Constant forward speed
const MAX_ROTATION: float = 0.9     # Max tilt in radians (~23 degrees)
@onready var val: AudioStreamPlayer2D = $val

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += GRAVITY * delta

	# PC: Space/Enter (ui_accept)
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = FLAP_STRENGTH
		val.play()
	# Constant forward movement
	velocity.x = FORWARD_SPEED

	# Apply movement
	move_and_slide()

	# Tilt (rotate) bird based on vertical velocity
	if velocity.y < 0:  # going up
		rotation = lerp(rotation, -MAX_ROTATION, 0.1)
	else:  # falling
		rotation = lerp(rotation, MAX_ROTATION, 0.05)


func _unhandled_input(event: InputEvent) -> void:
	# Mobile: Screen touch anywhere
	if event is InputEventScreenTouch and event.pressed:
		velocity.y = FLAP_STRENGTH
		val.play()
