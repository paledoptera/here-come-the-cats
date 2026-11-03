extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Soul:
		return

	Party.hero[0].hp += 50.0
	Sound.play(preload("uid://dn6sygxxt1y8u"))
	
	queue_free()
	
