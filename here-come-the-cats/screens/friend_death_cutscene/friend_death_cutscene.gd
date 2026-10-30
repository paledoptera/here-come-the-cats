extends Node

func _ready() -> void:
	Global.save_file.completed = true
	Global.save_file.save_data()
	Music.stop()
	await get_tree().create_timer(12.0).timeout
	SceneLoader.change_scene(preload("uid://byl3bkak2eqx5"))
