extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Soul:
		if body.dashing:
			get_owner().destroy()
