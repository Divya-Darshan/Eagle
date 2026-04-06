extends Node2D

var top_players: Array = []
var prev_players: Array = []
var is_menu_open: bool = false
@onready var leader: Label = $leader

var http: HTTPRequest
var poll_timer: Timer

func _ready() -> void:
	http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	
	poll_timer = Timer.new()
	add_child(poll_timer)
	poll_timer.wait_time = 5.0
	poll_timer.one_shot = false
	poll_timer.timeout.connect(_on_poll_timeout)

func _on_open_pressed() -> void:
	is_menu_open = true
	fetch_leaderboard()
	poll_timer.start()

func _on_close_pressed() -> void:
	is_menu_open = false
	print("Main menu closed - Stopping updates")
	poll_timer.stop()
	top_players.clear()
	prev_players.clear()
	leader.text = ""

func _on_poll_timeout() -> void:
	if is_menu_open:
		fetch_leaderboard()

func fetch_leaderboard() -> void:
	http.request("https://eagle-score.onrender.com/leaderboard")

func _on_request_completed(result: int, _response_code: int, _headers: Array, body: PackedByteArray) -> void:
	if not is_menu_open:
		return
	
	top_players.clear()
	leader.text = "⏳ Updating..."
	
	if result != HTTPRequest.RESULT_SUCCESS:
		leader.text = "❌ Connection failed"
		return
	
	var json_text = body.get_string_from_utf8()
	var data = JSON.parse_string(json_text)
	if data == null:
		leader.text = "❌ Bad data"
		return
	
	if data is Array:
		top_players = data
	elif data is Dictionary:
		top_players = [data]
	
	update_leaderboard_label()

func update_leaderboard_label() -> void:
	var text = ""

	if top_players.size() == 0:
		text += "No players yet\n"
	else:
		for i in range(top_players.size()):
			var player = top_players[i]
			if player is Dictionary:
				text += "  " + str(i+1) + ". " + str(player.get("username", "???")) + " - " + str(player.get("score", 0)) + "\n"
	
	
	leader.text = text
