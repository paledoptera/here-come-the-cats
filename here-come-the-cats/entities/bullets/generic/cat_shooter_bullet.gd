extends Bullet


func shoot() -> void:
	var soul = get_tree().get_first_node_in_group("soul")
	%BulletSpawner.parent = get_parent()
	%BulletSpawner.spawn(%BulletSpawner.global_position,soul.global_position)
