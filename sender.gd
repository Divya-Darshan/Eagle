extends Node

@onready var http: HTTPRequest = $"HTTPRequest"

@onready var USERNAME_PATH := "user://username.save"
@onready var COINS_PATH := "user://coins.save"

var username: String = ""
var coins: float = 0.0


func _ready() -> void:
	load_data()

	# ✅ Connect the signal safely
	if http:
		http.request_completed.connect(_on_request_completed)
	else:
		push_error("❌ ERROR: HTTPRequest node not found!")
		return

	# ✅ ✅ WAIT so mobile can load correct score (IMPORTANT FIX)
	await get_tree().create_timer(3).timeout

	# ✅ Send data to Python server
	send_to_server(username, coins)

# -------------------------------------------------------
# ✅ Load username + coins
# -------------------------------------------------------
func load_data() -> void:
	# Username
	if FileAccess.file_exists(USERNAME_PATH):
		var f = FileAccess.open(USERNAME_PATH, FileAccess.READ)
		username = str(f.get_var())
	else:
		username = "Player"

	# Coins / Score
	if FileAccess.file_exists(COINS_PATH):
		var f = FileAccess.open(COINS_PATH, FileAccess.READ)
		coins = float(f.get_var())
	else:
		coins = 0.0

	print("✅ Loaded Username:", username)
	print("✅ Loaded Score:", coins)



# -------------------------------------------------------
# ✅ Send to Python server
# -------------------------------------------------------
func send_to_server(username: String, score: float) -> void:
	var data := {
		"username": username,
		"score": score
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
