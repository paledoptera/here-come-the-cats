class_name CatBoss extends Area2D

signal soul_entered_bite_area
signal soul_exited_bite_area

func bullet_shot(damage: int, other_bullet: Area2D) -> void:
	var final_damage: int = 0
	if damage < 10.0:
		final_damage = [1,1,2].pick_random()
		Sound.play(preload("uid://d08c3mqmqumij"),0.6,randf_range(0.9,1.1))
		other_bullet.queue_free()
	else:
		final_damage = PartyAttackFormula.calculate(damage*3,Party.hero[0],Party.enemy[0])
		Sound.play(preload("uid://dvuvxfskkh7fn"),0.8,randf_range(0.9,1.1))
		$Damage.play("hurt")
		final_damage += randi_range(-15,15)
		other_bullet.queue_free()
	
	
	var target = Party.enemy.pick_random()
	
	target.hp -= final_damage
	print("NEW HP: ", target.hp)
	var damage_number = FloatingText.initialize_text(str(final_damage),Color.WHITE)
	Actors.trigger_damage_number(target.character_id,damage_number,other_bullet.global_position,true)


func _on_bite_zone_body_entered(body: Node2D) -> void:
	if body is Soul:
		soul_entered_bite_area.emit()

func _on_bite_zone_body_exited(body: Node2D) -> void:
	if body is Soul:
		soul_exited_bite_area.emit()
