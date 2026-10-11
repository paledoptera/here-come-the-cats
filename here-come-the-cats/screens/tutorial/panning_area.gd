extends Area2D

signal pan_to(area2d: Area2D)


func _on_body_entered(body: Node2D) -> void:
	if body is SoulFriend:
		pan_to.emit(self)
