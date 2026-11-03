extends Node


const TITLE_SCREEN = preload("uid://bo0085uf4akr6")
const GAME_OVER = preload("uid://coe5g12bxe24k")
const PHASE1 = preload("uid://ddmjcvocbt7r1")

enum GameState { TITLE, PROLOGUE, PHASE1, PHASE2, END}

var game_state: GameState = GameState.TITLE
var soul_screen_pos:= Vector2.ZERO

func _ready() -> void:
	Global.game_restarted.connect(_restart_game)

func change_scene(scene: PackedScene) -> Node:
	var scene_inst = scene.instantiate()
	get_tree().change_scene_to_node(scene_inst)
	return scene_inst

func _restart_game():
	change_scene(TITLE_SCREEN)

func goto_title() -> void:
	get_tree().unload_current_scene()
	change_scene(TITLE_SCREEN)

func goto_phase1() -> void:
	get_tree().unload_current_scene()
	change_scene(PHASE1)

func goto_gameover() -> void:
	var soul = get_tree().get_first_node_in_group("soul")
	var center_pos = soul.get_viewport().get_camera_2d().get_screen_center_position()
	soul_screen_pos = soul.global_position - (center_pos - Vector2(320.0,240.0))
	get_tree().unload_current_scene()
	change_scene(GAME_OVER)

func goto_last_gamestate() -> void:
	match game_state:
		GameState.TITLE:
			goto_title()
		GameState.PHASE1:
			goto_phase1()
