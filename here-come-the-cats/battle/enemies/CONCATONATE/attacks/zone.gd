extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body is SoulFriend:
		SceneLoader.goto_end_cutscene()
	pass # Replace with function body.
