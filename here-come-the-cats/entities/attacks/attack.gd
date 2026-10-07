class_name Attack extends Node2D

@export var time: float = 1.0
@export var wait_for_bullets: bool = false
@export var id: StringName = "attack"

func _process(delta: float) -> void:
	time -= delta
	if time <= 0.0:
		if not wait_for_bullets:
			queue_free()
		elif get_child_count() == 0:
			queue_free()

func start(with_time: float):
	time = with_time
