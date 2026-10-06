extends Node

var coins: int = 0
var player_position: Vector2 = Vector2.ZERO # Переменная для хранения позиции

func save_data() -> void:
	var file = FileAccess.open("user://save_data.dat", FileAccess.WRITE)
	if file:
		file.store_32(coins)              # 1. Записываем монеты
		file.store_float(player_position.x) # 2. Записываем X
		file.store_float(player_position.y) # 3. Записываем Y
		file.close()

func load_data() -> void:
	if FileAccess.file_exists("user://save_data.dat"):
		var file = FileAccess.open("user://save_data.dat", FileAccess.READ)
		if file:
			coins = file.get_32()            # 1. Считываем монеты
			var pos_x = file.get_float()      # 2. Считываем X
			var pos_y = file.get_float()      # 3. Считываем Y
			player_position = Vector2(pos_x, pos_y)
			file.close()
