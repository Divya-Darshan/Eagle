extends Label

var t: float = 0.0
var start_y: float = 0.0
const AMPLITUDE := 0.5     # base movement distance (pixels)
const SPEED := 0.5         # base speed
const RANDOM_STRENGTH := 0.1  # how much randomness affects the motion (0.0–1.0)

func _ready() -> void:
	start_y = position.y
	randomize()  # ensure different random seed each run

func _process(delta: float) -> void:
	# Add tiny, smooth random variation to speed and amplitude
	var random_speed := SPEED + randf_range(-RANDOM_STRENGTH, RANDOM_STRENGTH) * 0.2
	var random_amp := AMPLITUDE + randf_range(-RANDOM_STRENGTH, RANDOM_STRENGTH)

	# Update time
	t += delta * random_speed * TAU

	# Smooth wave with cubic easing
	var wave: float = sin(t)
	var eased_wave: float = pow(wave, 3)

	# Apply natural, slightly randomized vertical motion
	position.y = start_y + eased_wave * random_amp
