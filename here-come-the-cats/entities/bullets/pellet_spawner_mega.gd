extends Node2D
class_name BulletSpawnerMega

@export var bullet: PackedScene
@export var rare_bullet: PackedScene
@export var spawnpoints: Array[Marker2D]
@export var spawn_amount_min: int = -1
@export var spawn_amount_max: int = -1
@export var speed_mult_min: float = -1
@export var speed_mult_max: float = -1
@export var parent: Node
@export var speed_mult: float = 1.0
@export var sound: AudioStream

func _ready() -> void:
	if not spawnpoints:
		for i in get_children():
			if i is Marker2D:
				spawnpoints.append(i)

func spawn(spawn_position: Vector2 = global_position, aim_position:= Vector2.ZERO) -> Array[Node]:
	if aim_position != Vector2.ZERO:
		look_at(aim_position)
	
	global_position = spawn_position
	
	var bullets: Array[Node] = []
	
	if sound:
		Sound.play(sound,0.5)
	
	var spawn_amount = spawnpoints.size()
	
	if spawn_amount_min == -1 and spawn_amount_max == -1:
		pass
	else:
		spawn_amount = randi_range(spawn_amount_min,spawn_amount_max)
	
	var rand_speed_mult: bool = false
	if speed_mult_min == -1 and speed_mult_max == -1:
		pass
	else:
		rand_speed_mult = true
	
	spawnpoints.shuffle()
	
	var num: int = 0
	
	for i in spawnpoints:
		var spawn_pos = i.global_position
		var spawn_rot = i.global_rotation
		var bullet_inst
		if rare_bullet:
			var random_chance = randi_range(0,10)
			if random_chance < 3:
				bullet_inst = rare_bullet.instantiate()
			else:
				bullet_inst = bullet.instantiate()
		else:
			bullet_inst = bullet.instantiate()
		parent.add_child(bullet_inst)
		bullets.append(bullet_inst)
		bullet_inst.global_position = spawn_pos
		bullet_inst.global_rotation = spawn_rot
		
		bullet_inst.speed_multiplier = speed_mult
		if rand_speed_mult:
			bullet_inst.speed_multiplier = randf_range(speed_mult_min,speed_mult_max)
	
		
		print("speed mult: ", bullet_inst.speed_multiplier)
		bullet_inst.velocity = bullet_inst.velocity.rotated(bullet_inst.global_rotation)
		num += 1
		if num > spawn_amount:
			break
	
	return bullets
