extends Node

var level = 1
var coins = 0
var played_before = false
var can_skip = true


		
func save_game():
	var data = {
		"level": level,
		"coins": coins
	}

	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_game():
	if FileAccess.file_exists("user://save.json"):
		played_before = true
		var file = FileAccess.open("user://save.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()

		level = int(data["level"])
		coins = int(data["coins"])


func reset_game():
	level = 1
	coins = 0
	save_game()
