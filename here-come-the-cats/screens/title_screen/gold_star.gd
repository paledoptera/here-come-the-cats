extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().physics_frame
	if Global.save_file.completed:
		visible = true
	else:
		visible = false
