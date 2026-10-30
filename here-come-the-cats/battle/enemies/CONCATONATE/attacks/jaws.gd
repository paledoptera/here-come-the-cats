extends PathFollow2D

@export var speed: float = 1.0
@export var target: Soul

func _process(delta: float) -> void:
	progress += speed * delta
