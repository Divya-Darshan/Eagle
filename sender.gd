extends Node
@onready var http: HTTPRequest = $"HTTPRequest"
@onready var USERNAME_PATH := "user://username.save"
@onready var COINS_PATH := "user://coins.save"
var username: String = ""
var coins: float = 0.0

func _ready() -> void:
	load_data()
	if http:
		http.request_completed.connect(_on_request_completed)
	else:
		push_error("❌ ERROR: HTTPRequest node not found!")
		return
	await get_tree().create_timer(3).timeout
	send_to_server(username, coins)

# -------------------------------------------------------
# ✅ Load username + coins (fixed coins loading)
# -------------------------------------------------------
func load_data() -> void:
	# Username
	if FileAccess.file_exists(USERNAME_PATH):
		var f = FileAccess.open(USERNAME_PATH, FileAccess.READ)
		username = str(f.get_var())
	else:
		username = "Player"
	# Coins / Score (robust for mobile + PC)
	if FileAccess.file_exists(COINS_PATH):
		var f = FileAccess.open(COINS_PATH, FileAccess.READ)
		var val = f.get_var()
		if typeof(val) == TYPE_STRING:
			coins = float(val)
		elif typeof(val) == TYPE_FLOAT or typeof(val) == TYPE_INT:
			coins = float(val)
		else:
			coins = 0.0 # fallback if type unexpected
		print("✅ Loaded Score:", coins)
	else:
		coins = 0.0
		print("❌ Coins file not found. Defaulting to 0.0")
	print("✅ Loaded Username:", username)

# -------------------------------------------------------
# ✅ Send to Python server
# -------------------------------------------------------
func send_to_server(username: String, score: float) -> void:

	var data := {
		"username": username,
		"score": score,
	}
	var json_body := JSON.stringify(data)
	var err := http.request(
		"https://eagle-score.onrender.com/submit_score",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		json_body
	)
	if err != OK:
		print("❌ HTTP Request Error:", err)
	else:
		print("📡 Sending to server:", json_body)

# -------------------------------------------------------
# ✅ Server Response
# -------------------------------------------------------
func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	var text: String = body.get_string_from_utf8()
	print("✅ Server Response:", response_code, text)
