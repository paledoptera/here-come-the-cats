extends Node

func _ready() -> void:
	$MenuInputManager.open_menu($Options)


func _on_option_selected(index: int) -> void:
	match index:
		0: # Start
			Music.stop()
			if Global.options.skip_prologue:
				SceneLoader.change_scene(preload("uid://ddmjcvocbt7r1"))
			else:
				SceneLoader.change_scene(preload("uid://wfktweg8on8i"))
	pass # Replace with function body.
