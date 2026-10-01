extends Area2D

@export var damage: int = 1

func _physics_process(delta: float) -> void:
	global_position.x += 400.0 * delta



func _on_area_entered(area: Area2D) -> void:
	if area is Bullet and area.shootable:
		area.bullet_shot(damage)
		destroy()
	if area is Switch:
		area.trigger()
		destroy()

func destroy() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
