extends Node

func _ready() -> void:
	$MenuInputManager.open_menu($Options)


func _on_option_selected(index: int) -> void:
	match index:
		6: # Here come the cats
			SceneLoader.change_scene(preload("uid://ddmjcvocbt7r1"))
	pass # Replace with function body.
