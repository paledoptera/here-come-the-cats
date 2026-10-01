extends Node2D

@export var offset:= Vector2.ZERO
var on: bool = false
var base_pos: Vector2

func _ready() -> void:
	base_pos = position

func _process(delta: float) -> void:
	if on:
		position = position.slerp(base_pos + offset,0.3)
	else:
		position = position.slerp(base_pos,0.3)
