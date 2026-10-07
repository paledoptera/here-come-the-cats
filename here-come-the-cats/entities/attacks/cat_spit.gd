extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BulletSpawner.rotation_degrees += randf_range(-38.0,38.0)
	$BulletSpawner.spawn()
