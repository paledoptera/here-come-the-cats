extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Soul:
		return
	
	EventBus.coin_collected.emit()
	Sound.play(preload("res://shared/sound_effects/snd_coin.wav"))
	queue_free()
	
