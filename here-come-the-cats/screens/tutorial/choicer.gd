extends Node2D

var active: bool = false
var choice: int = 0

signal choice_made(choice: int)

func _ready() -> void:
	if not active:
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not active:
		if visible:
			visible = false
		return
	
	if not visible:
		visible = true
	
	var last_choice = choice
	
	if Input.is_action_just_pressed("left"):
		choice = 0
	elif Input.is_action_just_pressed("right"):
		choice = 1
	elif Input.is_action_just_pressed("confirm"):
		active = false
		Sound.play(preload("uid://dbxc1pv4kqsht"))
		choice_made.emit(choice)
	
	if last_choice != choice:
		Sound.play(preload("uid://c7si5enlp24hs"))
