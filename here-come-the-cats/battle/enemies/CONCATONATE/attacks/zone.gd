extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body is SoulFriend:
		SceneLoader.change_scene(preload("uid://bnoydr27bs3on"))
	pass # Replace with function body.
