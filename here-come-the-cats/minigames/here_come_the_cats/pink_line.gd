extends Path2D

@export var color = Color.HOT_PINK
@export var loop: bool = true

func _draw():
	draw_polyline(curve.get_baked_points(), Color.BLACK, 6.0)
	draw_polyline(curve.get_baked_points(), color, 3.0)
