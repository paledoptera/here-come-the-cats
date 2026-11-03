extends Sprite2D
@export var target: Node2D

func _process(delta: float) -> void:
	if target:
		look_at(target.global_position)
