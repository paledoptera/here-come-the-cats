extends Path2D

@export var loop: bool = true

func _draw():
	draw_polyline(curve.get_baked_points(), Color.BLACK, 6.0)
	draw_polyline(curve.get_baked_points(), Color.HOT_PINK, 3.0)
