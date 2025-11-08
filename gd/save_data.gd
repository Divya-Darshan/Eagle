extends Node

var coins: float = 0.0
const SAVE_PATH := "user://savegame.json"

func _ready():
	load_game()

func add_coin(value := 0.5):
	coins += value
	save_game()

func reset():
	coins = 0.0
	save_game()

func save_game():
	var data = {
		"coins": coins
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	print("✅ Saved:", data)

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("⚠ No save found, starting new.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	var result = JSON.parse_string(content)

	if result:
		coins = result["coins"]
		print("✅ Loaded:", coins)
