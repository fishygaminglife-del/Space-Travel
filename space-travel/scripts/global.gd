extends Node

var level = 1
var coins = 30
var played_before = false
var can_skip = false
var hearts = 4
var dwnhearts = false
var armor = 0
var shield = false
var dead = false
var shield_enabled = false

		
func save_game():
	var data = {
		"level": level,
		"coins": coins,
		"armor": armor,
		"shield": shield
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

		level = int(data.get("level", 1))
		coins = int(data.get("coins", 0))
		armor = int(data.get("armor", 0))
		shield = bool(data.get("shield", false))

func reset_game():
	level = 1
	coins = 0
	armor = 0
	shield = false
	save_game()
