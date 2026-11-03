class_name StoryBossConcateny extends StoryBattleController



func player_turn_end() -> void:
	if battle.turn >= 3:
		Party.enemy[0].attack_list = preload("uid://dkx2t1d6e7qst")
		
	if battle.turn >= 4:
		Party.enemy[0].dialogue.clear()
	
	if Party.enemy[0].hp <= 200:
		Party.enemy[0].dialogue.clear()
		Party.enemy[0].dialogue.append(preload("uid://d1h2u1mju8bf6"))
		Party.enemy[0].attack_list = preload("uid://i4lghp42u6ys")
	
	await Party.get_tree().physics_frame
	finished.emit()
