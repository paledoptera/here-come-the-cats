extends Node

const TITLE_SCREEN = preload("uid://bo0085uf4akr6")

func _ready() -> void:
	Global.game_restarted.connect(_restart_game)

func change_scene(scene: PackedScene) -> Node:
	var scene_inst = scene.instantiate()
	get_tree().change_scene_to_node(scene_inst)
	return scene_inst

func _restart_game():
	change_scene(TITLE_SCREEN)
