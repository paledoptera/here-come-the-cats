extends Node


var choice: int = -1
var target: Node:
	set(value):
		if target:
			target.modulate = Color.WHITE
		target = value
		
var x_offset: float = 0.0
var can_make_choice: bool = false
var choice_made: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.stop()
	$Sprite2D.position = SceneLoader.soul_screen_pos
	
	if Global.cause_of_death == "cat_clock":
		$Extra.play("cat_clock")
	Global.cause_of_death = ""
	
	await get_tree().create_timer(4.0).timeout
	Music.play(preload("uid://i0nld8865mhn"),1.0)
	await get_tree().create_timer(1.0).timeout
	can_make_choice = true
	

func _process(delta: float) -> void:
	if not can_make_choice or choice_made:
		return
	
	if Input.is_action_just_pressed("left"):
		choice = 0
	elif Input.is_action_just_pressed("right"):
		choice = 1
	
	if Input.is_action_just_pressed("confirm"):
		Sound.play(preload("uid://dbxc1pv4kqsht"))
		choice_made = true
		$AnimationPlayer.play("leave")
		Music.stop()
		await get_tree().create_timer(3.0).timeout
		SceneLoader.goto_last_gamestate()
		return
	
	match choice:
		0:
			target = %CONTINUE
			x_offset = 50.0
		1:
			target = %GIVEUP
			x_offset = 50.0
	
	
	if target:
		%Selector.global_position.x = lerp(%Selector.global_position.x,target.global_position.x+x_offset,0.3)
		target.modulate = Color.YELLOW
