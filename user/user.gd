extends Node

var username: String = ""
@onready var label: Label = $Label
const SAVE_PATH := "user://username.save"

func _ready():
	load_username()
	
	if username == "":
		# Get system username or fallback
		var base_name: String
		if OS.has_environment("USERNAME"):
			base_name = OS.get_environment("USERNAME")
		elif OS.has_environment("USER"):
			base_name = OS.get_environment("USER")
		else:
			base_name = "Player"
		
		# Make it unique by appending a random number
		var unique_number = randi() % 10000   # 0-9999
		username = "%s_%04d" % [base_name, unique_number]
		
		save_username()
	
	update_label()
	print("Username:", username)

func update_label():
	label.text = "Hello, " + username

func save_username():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(username)
	file.close()

func load_username():
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		username = str(file.get_var())
		file.close()
	else:
		username = ""
