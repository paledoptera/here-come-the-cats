extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Party.hero:
		Flags.story.phase2_dess_start_hp = Party.hero[0].hp
	if Party.enemy:
		Party.enemy[0].hp = min(Party.enemy[0].hp,1200)
		Flags.story.phase2_friend_start_hp = Party.enemy[0].hp
	SceneLoader.game_state = SceneLoader.GameState.PHASE2

func start_battle() -> void:
	SceneLoader.goto_phase2()
