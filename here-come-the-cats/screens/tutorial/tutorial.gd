extends Node2D

var camera_pan_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoulFriend.taking_input = false
	$AnimationPlayer.play("start")
	await $AnimationPlayer.animation_finished
	await display_dialogue(preload("uid://fnjx16nudgv6"))
	await get_tree().create_timer(0.5).timeout
	Music.enable_rhythm = false
	Music.play(preload("uid://djc7ap5o0cu3c"),1.0,0.0)
	await get_tree().create_timer(1.5).timeout
	await display_dialogue(preload("uid://dgg7i6ywnhlh2"))
	$AnimationPlayer.play("pan_over")
	await get_tree().create_timer(1.5).timeout
	await display_dialogue(preload("uid://cgl387m7bi5uw"))
	$SoulFriend.taking_input = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_pink_area_body_entered(body: Node2D) -> void:
	if body is SoulFriend:
		if body.soul_state == SoulFriend.SoulState.PINK:
			return
		body.soul_state = SoulFriend.SoulState.PINK
		body.play_switch_animation()
		Sound.play(preload("res://shared/sound_effects/snd_smallswing.wav"))

func _on_yellow_area_body_entered(body: Node2D) -> void:
	if body is SoulFriend:
		if body.soul_state == SoulFriend.SoulState.YELLOW:
			return
		body.soul_state = SoulFriend.SoulState.YELLOW
		Sound.play(preload("res://shared/sound_effects/snd_smallswing.wav"))
		body.play_switch_animation()


func _on_panning_area_body_entered(body: Node2D) -> void:
	if body is SoulFriend:
		pan_camera(Vector2(300.0,0.0),2.0)
		pass

func pan_camera(new_pos: Vector2, length: float = 0.5) -> void:
	if camera_pan_tween:
		camera_pan_tween.kill()
	camera_pan_tween = create_tween()
	camera_pan_tween.tween_property($CameraPivot,"position",new_pos,length).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	


func _on_panning_pan_to(area2d: Area2D) -> void:
	match area2d.name:
		"PanningArea1":
			display_dialogue(preload("uid://br0c02ll8dnix"))
			pan_camera(Vector2(300.0,0.0),2.0)
		"PanningArea2":
			
			pan_camera(Vector2(700.0,0.0),2.0)
		"PanningArea3":
			display_dialogue(preload("uid://b4o364owsfvj1"))
			pan_camera(Vector2(1050.0,0.0),2.0)
		"PanningArea4":
			pan_camera(Vector2(1350.0,0.0),2.0)
		"PanningArea5":
			display_dialogue(preload("uid://ccoi1bwqn3bfb"))
			$AnimationPlayer.play("investigate")
			pan_camera(Vector2(1850.0,0.0),4.0)
	area2d.queue_free()

func display_dialogue(dialogue: Variant) -> void:
	$CanvasLayer/DialogueBox2.visible = true
	Dialogue.display_text(dialogue)
	await Dialogue.text_finished
	Dialogue.clear_text.emit()
	$CanvasLayer/DialogueBox2.visible = false


func _on_cutscene_area_body_entered(body: Node2D) -> void:
	if body is SoulFriend:
		cutscene()


func cutscene() -> void:
	Music.stop()
	$SoulFriend.queue_free()
	$AnimationPlayer.play("soul_enter")
	await $AnimationPlayer.animation_finished
	await display_dialogue(preload("uid://cow55bc8uwjn6"))
	await get_tree().create_timer(0.8).timeout
	await display_dialogue(preload("uid://d2p33mim41gpo"))
	await get_tree().create_timer(0.8).timeout
	await display_dialogue(preload("uid://woq0nqm2f3ih"))
	await get_tree().create_timer(2.0).timeout
	Music.play(preload("uid://b645uso14618g"))
	await display_dialogue(preload("uid://bl28e0u541y4f"))
	await get_tree().create_timer(0.5).timeout
	await display_dialogue(preload("uid://cbhon5yrqvilr"))
	Music.stop()
	await get_tree().create_timer(1.0).timeout
	SceneLoader.change_scene(preload("uid://ddmjcvocbt7r1"))
	
