extends Node

@onready var http: HTTPRequest = $HTTPRequest

const USERNAME_PATH := "user://username.save"
const COINS_PATH := "user://coins.save"

var username: String = ""
var coins: float = 0.0


func _ready() -> void:
	load_data()

	# Connect callback
	http.request_completed.connect(_on_request_completed)

	# Send data to server
	send_to_server(username, coins)



# -------------------------------------------------------
# ✅ Load username + coins
# -------------------------------------------------------
func load_data() -> void:
	# Load username
	if FileAccess.file_exists(USERNAME_PATH):
		var f = FileAccess.open(USERNAME_PATH, FileAccess.READ)
		username = str(f.get_var())
	else:
		username = "Player"

	# Load coins
	if FileAccess.file_exists(COINS_PATH):
		var f = FileAccess.open(COINS_PATH, FileAccess.READ)
		coins = float(f.get_var())
	else:
		coins = 0.0

	print("Loaded Username:", username)
	print("Loaded Coins:", coins)



# -------------------------------------------------------
# ✅ Send data to server (Godot 4 correct format)
# -------------------------------------------------------
func send_to_server(username: String, score: float) -> void:
	var data := {
		"username": username,
		"score": score
	}

	var body := JSON.stringify(data)

	var err = http.request(
		"http://127.0.0.1:8000/submit_score",
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		body
	)

	if err != OK:
		print("HTTP Request Error:", err)
	else:
		print("Sending:", body)



# -------------------------------------------------------
# ✅ Callback when Python server responds
# -------------------------------------------------------
func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	var text: String = body.get_string_from_utf8()
	print("Server Response:", response_code, text)
