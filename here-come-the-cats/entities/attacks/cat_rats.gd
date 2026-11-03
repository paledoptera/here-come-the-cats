extends Attack

const RAT = preload("uid://b2fc20c7ycwg6")
var count: int = 0
var line: Path2D

func _ready() -> void:
	var time = randf_range(0.1,0.5)
	count = randi_range(3,5)
	line = get_tree().get_first_node_in_group("pink_lines")
	$Timer.start(time)


func _on_timer_timeout() -> void:
	count -= 1
	
	var rat = RAT.instantiate()
	line.add_child(rat)
	rat.progress = line.curve.get_closest_offset(line.to_local(global_position))
	
	if count <= 0:
		queue_free()
