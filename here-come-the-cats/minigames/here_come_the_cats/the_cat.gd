class_name CatBoss extends Area2D

func bullet_shot(damage: int, other_bullet: Area2D) -> void:
	var final_damage: int = 0
	if damage < 10.0:
		final_damage = [1,1,2].pick_random()
	else:
		final_damage = PartyAttackFormula.calculate(damage,Party.hero[0],Party.enemy[0])
	
		final_damage += randi_range(-15,15)
	
	Sound.play(preload("uid://dvuvxfskkh7fn"))
	var target = Party.enemy.pick_random()
	
	target.hp -= final_damage
	print("NEW HP: ", target.hp)
	var damage_number = FloatingText.initialize_text(str(final_damage),Color.WHITE)
	Actors.trigger_damage_number(target.character_id,damage_number,other_bullet.global_position,true)
