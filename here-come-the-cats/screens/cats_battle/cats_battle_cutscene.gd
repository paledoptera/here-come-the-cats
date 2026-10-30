extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await $AnimationPlayer.animation_finished
	var dialogue = DialogueString.new("[shake]* The tail of hell takes crawl.")
	dialogue.is_skippable = false
	Dialogue.display_text(dialogue)
	pass # Replace with function body.


func start_battle() -> void:
	Battle.start(preload("uid://bpxsuw7g4pshc"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
