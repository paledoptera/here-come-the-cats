class_name HomeRunEffect extends Effect

var buster_timer: SceneTreeTimer
var animation_finished: bool = false
var dialogue_finished: bool = false

func apply(user: int, target: int) -> void:
	##var target = Battle.get_target_enemy()
	var hero = Party.get_target_hero(user)
	var enemy = Party.get_target_enemy(target)
	var damage = (float(hero.attack) * 11) + (5 * hero.magic) - (3 * enemy.defense)
	var string = "* %s used X-Strike!"
	var final_string = string % hero.name
	
	Dialogue.display_text(final_string)
	Actors.do_action(hero.character_id, "home_run")
	buster_timer = Global.get_tree().create_timer(1.0)
	show_damage_number(damage, enemy)
	await Dialogue.text_finished
	Dialogue.clear_text.emit()
	if buster_timer:
		if buster_timer.time_left > 0.0:
			await buster_timer.timeout
	enemy.hp -= damage
	effect_applied.emit()

func show_damage_number(damage: float, enemy: CharacterStats) -> void:
	await Global.get_tree().create_timer(0.5).timeout
	Actors.do_action(enemy.character_id, "hurt_hard")
	Sound.play(preload("uid://d1epw8l8augow"))
	var damage_number = FloatingText.initialize_text(str(int(damage)),Color.WHITE)
	Actors.trigger_damage_number(enemy.character_id,damage_number)
	
