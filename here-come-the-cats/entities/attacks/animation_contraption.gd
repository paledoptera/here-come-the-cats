extends Node2D

var on: bool = false
var anim: AnimationPlayer

func _ready() -> void:
	anim = get_child(0)

func _process(delta: float) -> void:
	if on:
		anim.pause()
	else:
		anim.play()
	
