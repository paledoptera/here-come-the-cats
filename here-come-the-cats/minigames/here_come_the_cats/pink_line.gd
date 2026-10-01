extends Path2D

func _draw():
	draw_polyline(curve.get_baked_points(), Color.BLACK, 6.0)
	draw_polyline(curve.get_baked_points(), Color.HOT_PINK, 3.0)
