class_name PartyAttackFormula extends DamageFormula

static func calculate(value: int, attacker: CharacterStats, target: CharacterStats) -> int:
	var accuracy = float(value)
	var attack = float(attacker.attack)
	
	var damage = ((attack * accuracy)/20) - (target.defense*3)
	
	print(" ATTACK ", attack, " ACCURACY ", accuracy, " TOTAL ", ((attack * accuracy)/20), " - TARGET DEFENSE: ", (target.defense*3))
	damage = max(damage,1)
	
	return damage
