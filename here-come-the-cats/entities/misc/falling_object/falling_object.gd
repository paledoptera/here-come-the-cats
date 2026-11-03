extends Node2D

var direction := Vector2.UP
var velocity := Vector2.ZERO
var grav := Vector2.DOWN * 5.0


func _ready() -> void:
	scale *= randf_range(1.0,1.2)
	direction = direction.rotated(randf_range(-0.1,0.1))
	velocity = direction * randf_range(150.0,250.0)
	grav *= randf_range(0.8,1.2)

func _physics_process(delta: float) -> void:
	velocity += grav
	
	
	global_position += (velocity * delta)
