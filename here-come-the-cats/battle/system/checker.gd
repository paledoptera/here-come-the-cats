extends Node

func _process(delta: float) -> void:
	## this is hardcoded here since this is already kind of a hodgepodge
	## of my battle engine into this game.
	## absolutely terrible. do not do this. too bad!
	if Party.enemy[0].hp <= 0.0:
		print("SHIT")
		SceneLoader.change_scene(preload("uid://bnoydr27bs3on"))
		
