class_name SaveData extends RefCounted

const SAVE_PATH = "user://config.cfg"

var completed: bool = false

func save_data() -> void:
	var config = ConfigFile.new()
	config.set_value("game_data","completed",completed)
	config.save(SAVE_PATH)

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		completed = config.get_value("game_data","completed",false)
