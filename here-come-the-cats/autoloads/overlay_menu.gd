extends Node

signal game_restarted

enum Command { NONE, RESTART, QUIT}

var command: Command
var command_timer: float = 0.0
var buffer: float = 0.0


func _process(delta: float) -> void:
	if buffer > 0.0:
		command = Command.NONE
		buffer -= delta
		buffer = maxf(buffer,0.0)
		return
	
	
	if Input.is_action_pressed("restart_game"):
		command = Command.RESTART
	elif Input.is_action_pressed("quit_game"):
		command = Command.QUIT
	else:
		command = Command.NONE
		command_timer = 0.0
	
	if command == Command.NONE:
		return
	
	command_timer += delta
	
	if command_timer >= 1.0:
		command_timer = 0.0
		buffer = 2.0
		match command:
			Command.RESTART:
				EventBus.game_restarted.emit()
			Command.QUIT:
				get_tree().quit()
	
