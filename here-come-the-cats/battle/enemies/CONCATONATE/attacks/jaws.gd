extends PathFollow2D

@export var speed: float = 1.0
@export var target: Soul

func _process(delta: float) -> void:
	var local_pos = get_parent().to_local(target.global_position)
	var soul_pos = get_parent().curve.get_closest_offset(local_pos)
	progress = lerp(progress,soul_pos,speed*delta)
