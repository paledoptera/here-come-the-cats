extends Node2D

const EFFECT = preload("uid://bxqe0sybtpeif")
@export var large_coin: bool = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Soul:
		return
	
	
	if not large_coin:
		EventBus.coin_collected.emit()
	else:
		EventBus.large_coin_collected.emit()
	
	var effect = EFFECT.instantiate()
	get_parent().add_child(effect)
	effect.global_position = global_position
	
	queue_free()
	
