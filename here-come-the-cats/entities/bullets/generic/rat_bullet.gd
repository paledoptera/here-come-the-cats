extends Bullet

const FALLING_OBJECT = preload("uid://6tbpsp808hlq")
const COIN = preload("uid://yl17d5408wkl")
const CANDY = preload("uid://cmshuy1vufwt")
const PARTICLE = preload("uid://bjho8f8gw78rd")

func destroy() -> void:
	var particle = PARTICLE.instantiate()
	get_owner().add_child(particle)
	particle.emitting = true
	particle.finished.connect(particle.queue_free)
	particle.global_position = global_position
	
	Sound.play(preload("uid://dg4bj4ew6vni"),0.5,randf_range(0.7,1.0))
	Sound.play(preload("uid://b5a2ojoyp4oyr"),0.5,randf_range(0.9,1.1))
	
	queue_free()

func destroyed_by_shoot() -> void:
	drop_item()
	destroy()


func drop_item() -> void:
	var chance = [true,false].pick_random()
	if chance:
		var object = FALLING_OBJECT.instantiate()
		get_owner().add_child(object)
		object.global_position = global_position
		
		var attached_item = [COIN,CANDY].pick_random().instantiate()
		
		if Party.hero[0].hp >= Party.hero[0].hp_max:
			attached_item = COIN.instantiate()
	
		
		object.add_child(attached_item)
