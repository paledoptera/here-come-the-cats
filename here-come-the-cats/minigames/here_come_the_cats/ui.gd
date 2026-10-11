extends CanvasLayer

var ui_scale: float = 1.0
var ui_offset:= Vector2.ZERO

func _process(delta: float) -> void:
	follow_viewport_scale = lerp(follow_viewport_scale,ui_scale,0.2)
	offset = offset.lerp(ui_offset,0.2)

func _on_death_clock_impending_doom() -> void:
	ui_scale += 0.03
	ui_offset.y += 6.0
	pass # Replace with function body.
