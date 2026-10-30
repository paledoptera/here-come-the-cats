class_name DamageEffect extends Effect

@export var amount: int = 10

func apply(_user: int, target: int) -> void:
	damage(target)
	await Party.get_tree().physics_frame
	effect_applied.emit()

func damage(target: int) -> void:
	match target:
		Enums.Target.HERO:
			Party.get_target_hero(target).hp -= amount
		
		Enums.Target.ALL_HEROES:
			for i in Party.hero:
				i.hp -= amount
		
		Enums.Target.ENEMY:
			var hero = Party.get_target_hero(0)
			var enemy = Party.get_target_enemy(target)
			var final_damage = (float(hero.attack) * 11) + (5 * hero.magic) - (3 * enemy.defense)
			show_damage_number(final_damage, enemy)
			enemy.hp -= damage

		
		Enums.Target.ALL_ENEMIES:
			for i in Party.enemy:
				i.hp -= amount


func show_damage_number(fdamage: float, enemy: CharacterStats) -> void:
	Actors.do_action(enemy.character_id, "hurt_hard")
	var damage_number = FloatingText.initialize_text(str(int(fdamage)),Color.WHITE)
	Actors.trigger_damage_number(enemy.character_id,damage_number)
	
