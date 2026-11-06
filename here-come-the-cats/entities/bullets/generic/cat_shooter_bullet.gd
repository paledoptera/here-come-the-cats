extends Bullet

const PARTICLE = preload("uid://bjho8f8gw78rd")


func destroy() -> void:
	var particle = PARTICLE.instantiate()
	get_parent().add_child(particle)
	particle.global_position = global_position
	particle.emitting = true
	particle.finished.connect(particle.queue_free)
	

	Sound.play(preload("uid://dg4bj4ew6vni"),0.5,randf_range(0.7,1.0))
	Sound.play(preload("uid://dacv5eslc2kd8"),0.5,randf_range(0.9,1.1))
	
	queue_free()
func shoot() -> void:
	var soul = get_tree().get_first_node_in_group("soul")
	%BulletSpawner.parent = get_parent()
	%BulletSpawner.spawn(%BulletSpawner.global_position,soul.global_position)
