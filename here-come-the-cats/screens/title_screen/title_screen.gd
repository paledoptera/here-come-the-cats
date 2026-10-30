extends Node

func _ready() -> void:
	Global.save_file.load_data()
	$MenuInputManager.open_menu($Options)
	
	if Global.save_file.completed:
		%Extras.modulate = Color.WHITE
		%Extras.disabled = false
	else:
		%Extras.modulate = Color("6c6c6c")
		%Extras.disabled = true


func _on_option_selected(index: int) -> void:
	match index:
		0: # Start
			Music.stop()
			if Global.options.skip_prologue:
				SceneLoader.change_scene(preload("uid://ddmjcvocbt7r1"))
			else:
				SceneLoader.change_scene(preload("uid://wfktweg8on8i"))
	pass # Replace with function body.
