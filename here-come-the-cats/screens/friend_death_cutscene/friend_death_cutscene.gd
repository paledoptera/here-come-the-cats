extends Node

func _ready() -> void:
	Global.save_file.completed = true
	Global.save_file.save_data()
	Music.stop()
	%SOUL.position = SceneLoader.soul_screen_pos
	await get_tree().create_timer(26.0).timeout
	SceneLoader.change_scene(preload("uid://byl3bkak2eqx5"))
