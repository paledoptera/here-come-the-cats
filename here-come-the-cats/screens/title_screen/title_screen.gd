extends Node

var started: bool = false

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
			Music.fade_out(2.0)
			started = true
			$MenuInputManager.close_all_menus()
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(3.0).timeout
			if Global.options.skip_prologue:
				SceneLoader.change_scene(preload("uid://ddmjcvocbt7r1"))
			else:
				SceneLoader.change_scene(preload("uid://wfktweg8on8i"))
		2: # Quit
			get_tree().quit()
	pass # Replace with function body.
