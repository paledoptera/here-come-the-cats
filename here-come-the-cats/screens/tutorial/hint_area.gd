extends Area2D

var in_area: bool = false

func _ready() -> void:
	$Hint.modulate = Color.TRANSPARENT


func _process(delta: float) -> void:
	if in_area:
		$Hint.modulate = $Hint.modulate.lerp(Color.WHITE,0.1)
	else:
		$Hint.modulate = $Hint.modulate.lerp(Color.TRANSPARENT,0.1)


func _on_body_entered(body: Node2D) -> void:
	if body is Soul:
		in_area = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body is Soul:
		in_area = false
	pass # Replace with function body.
