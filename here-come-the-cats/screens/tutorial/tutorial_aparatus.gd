extends Node2D

signal event1
signal event2
signal event3

var event2_triggered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pipe_blocker_bullet_tree_exited() -> void:
	event1.emit()


func continue_to_phase2() -> void:
	$AnimationPlayer.play("phase2")

func continue_to_phase3() -> void:
	$AnimationPlayer.play("phase3")


func _on_switch_switched() -> void:
	if event2_triggered:
		return
	event2_triggered = true
	event2.emit()
	pass # Replace with function body.


func _on_pipe_blocker_bullet_11_tree_exited() -> void:
	event3.emit()
