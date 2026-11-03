extends Node2D

const RAT_RUNNER = preload("uid://b2fc20c7ycwg6")
var in_area: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not Soul:
		return
	
	in_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is not Soul:
		return
		
	in_area = false


func _on_timer_timeout() -> void:
	if not in_area:
		return
	
	var target = [$IntroUpperLine,$IntroUpperLine2].pick_random()
	
	var rat = RAT_RUNNER.instantiate()
	target.add_child(rat)
	rat.progress_ratio = 1.0
	rat.loop = false
