extends Node2D

@export var range: float = 10.0
@export var clamp: float = 10.0
@export var lerp: float = 0.25
@export var sine: float = 1.0
@export var offset:= Vector2(0.0,50.0)

@export var constant_offset:= Vector2(5.0,0.0)
var tail_segments: Array[Node]
var last_position: Vector2
var siner: float = 0.0

func _ready() -> void:
	tail_segments = get_children()
	for i in tail_segments:
		i.top_level = true
		i.scale = global_scale
		i.global_position = global_position

func _process(delta: float) -> void:
	siner += delta
	
	for i in range(tail_segments.size()):
		var siner_addition = float(i)*0.5
		var sine_offset = Siner.get_sine(siner+siner_addition,1.0,10.0)
		var segment = tail_segments[i]
		segment.global_position += offset*sine_offset
		segment.global_position += constant_offset
		if i == 0:
			segment.global_position = global_position
			continue
		
		if segment.global_position.distance_to(tail_segments[i-1].global_position) > clamp:
			segment.global_position = tail_segments[i-1].global_position.move_toward(segment.global_position,clamp)
		
