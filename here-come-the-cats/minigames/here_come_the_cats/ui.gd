extends CanvasLayer

@export var death_clock: DeathClock
var ui_scale: float = 1.0
var ui_offset:= Vector2.ZERO
var impending_doom: bool = false
var expanding_lerp: float = 0.0


func _process(delta: float) -> void:

	follow_viewport_scale = lerp(follow_viewport_scale,ui_scale,0.2)
	offset = offset.lerp(ui_offset,0.2)

	if death_clock:
		death_clock.position.x = 260.0
		if death_clock.time_left > -30.0:
			impending_doom = true
			return
		print("DEATHCLOCK", death_clock.time_left)
	
	follow_viewport_scale = 1.0
	offset = Vector2.ZERO
	ui_scale = 1.0
	ui_offset.y = 0.0
	print("NONE")


func _on_death_clock_impending_doom() -> void:
	ui_scale += 0.03
	ui_offset.y += 6.0
