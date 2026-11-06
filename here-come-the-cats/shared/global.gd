extends Node

enum Order { RANDOM, SEQUENTIAL }


signal game_restarted

var options:= CatsOptions.new()

var cause_of_death: String = ""
var save_file:= SaveData.new()

var backtraces: Array



var reset_timer: float = 0.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("restart_game"):
		reset_timer += delta
	else:
		reset_timer = 0.0
	
	if reset_timer >= 1.0:
		reset_timer = 0.0
		game_restarted.emit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
