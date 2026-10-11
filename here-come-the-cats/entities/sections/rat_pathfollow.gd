extends PathFollow2D
var speed: float = 300.0

func _process(delta: float) -> void:
	progress -= speed * delta
