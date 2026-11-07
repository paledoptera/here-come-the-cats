class_name StoryBossConcateny extends StoryBattleController

const FIGHT_DIALOGUE: Array[DialogueBlock] = [
	preload("uid://br2175r8g0dog"),
	preload('uid://f1ckoweyvbcb'),
	preload("uid://dpq6vhgvtpgd4"),
	preload("uid://c4mmrmscu6gcn")
]


func player_turn_end() -> void:
	if battle.turn == 0:
		
		Party.enemy[0].dialogue.clear()
		Party.enemy[0].dialogue = FIGHT_DIALOGUE.duplicate(true)
		Party.enemy[0].attack_list = preload("uid://bfd6w1gvoplgv")
		
	if battle.turn >= 3:
		Party.enemy[0].attack_list = preload("uid://dkx2t1d6e7qst")
	
	if battle.turn >= 4:
		print("TESTICLE")
		Party.enemy[0].dialogue.clear()
	
	
		if Party.enemy[0].hp <= 200:
			Party.enemy[0].dialogue.clear()
			Party.enemy[0].dialogue.append(preload("uid://d1h2u1mju8bf6"))
			Party.enemy[0].attack_list = preload("uid://i4lghp42u6ys")
	
	await Party.get_tree().physics_frame
	finished.emit()
