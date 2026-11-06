class_name SaveData extends RefCounted

const SAVE_PATH = "user://config.cfg"

var completed: bool = false
var no_hitted: bool = false

func save_data() -> void:
	var config = ConfigFile.new()
	config.set_value("game_data","completed",completed)
	config.set_value("game_data","no_hitted",no_hitted)
	config.save(SAVE_PATH)

func load_data() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		completed = config.get_value("game_data","completed",false)
		no_hitted = config.get_value("game_data","no_hitted",false)
