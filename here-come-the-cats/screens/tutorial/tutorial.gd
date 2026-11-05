extends Node

var camera_pan_tween: Tween
var soul: SoulFriend

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	soul = get_tree().get_first_node_in_group("soul")
	
	soul.taking_input = false
	await get_tree().create_timer(1.0).timeout
	$AnimationPlayer.play("start")
	await $AnimationPlayer.animation_finished
	await display_dialogue(preload("uid://fnjx16nudgv6"))
	$AnimationPlayer.play("throw_coin")
	$AnimationPlayer.queue("walk_to_guitar")
	$AnimationPlayer.queue("guitar_tune")
	await get_tree().create_timer(0.5).timeout
	Music.enable_rhythm = false
	Music.play(preload("uid://djc7ap5o0cu3c"),1.0,0.0)
	await get_tree().create_timer(1.5).timeout
	await display_dialogue(preload("uid://dgg7i6ywnhlh2"))
	$AnimationPlayer.play("flop")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("pan_over")
	await get_tree().create_timer(1.5).timeout
	await display_dialogue(preload("uid://cgl387m7bi5uw"))
	soul.taking_input = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_panning_pan_to(area2d: Area2D) -> void:
	match area2d.name:
		"PanningArea1":
			display_dialogue(preload("uid://br0c02ll8dnix"))
		"PanningArea2":
			pass
		"PanningArea3":
			display_dialogue(preload("uid://b4o364owsfvj1"))

		"PanningArea4":
			pass
		"PanningArea5":
			display_dialogue(preload("uid://ccoi1bwqn3bfb"))
			$AnimationPlayer.play("investigate")
	area2d.queue_free()

func display_dialogue(dialogue: Variant) -> void:
	%DialogueBox.visible = true
	Dialogue.display_text(dialogue)
	await Dialogue.text_finished
	Dialogue.clear_text.emit()
	%DialogueBox.visible = false



func _on_tutorial_aparatus_event_1() -> void:
	Sound.play(preload("res://shared/sound_effects/snd_b.wav"))
	$AnimationPlayer.play("investigate")
	await get_tree().create_timer(1.0).timeout
	display_dialogue(preload("uid://br0c02ll8dnix"))

func _on_tutorial_aparatus_event_2() -> void:
	$Barrier.visible = false
	Sound.play(preload("res://shared/sound_effects/snd_b.wav"),1.0,1.1)
	$AnimationPlayer.play("investigate_2")
	await get_tree().create_timer(0.5).timeout
	display_dialogue(preload("uid://b4o364owsfvj1"))
	await Dialogue.text_finished
	$AnimationPlayer.play("investigate_3")
	await get_tree().create_timer(4.0).timeout
	display_dialogue(preload("uid://ccoi1bwqn3bfb"))


func _on_tutorial_aparatus_event_3() -> void:
	soul.queue_free()
	Music.stop()
	$AnimationPlayer.play("soul_enter")
	await $AnimationPlayer.animation_finished
	await display_dialogue(preload("uid://cow55bc8uwjn6"))
	$AnimationPlayer.play("soul_bewilderment")
	await $AnimationPlayer.animation_finished
	await display_dialogue(preload("uid://d2p33mim41gpo"))
	await get_tree().create_timer(0.5).timeout
	await display_dialogue(preload("uid://dlm22t7sy3781"))
	$AnimationPlayer.play("soul_look")
	await $AnimationPlayer.animation_finished
	await display_dialogue(preload("uid://woq0nqm2f3ih"))
	await get_tree().create_timer(1.0).timeout
	$AnimationPlayer.play("rat_trap")
	await $AnimationPlayer.animation_finished
	Music.play(preload("uid://b645uso14618g"))
	await display_dialogue(preload("uid://bl28e0u541y4f"))
	await get_tree().create_timer(1.0).timeout
	await display_dialogue(preload("uid://cbhon5yrqvilr"))
	Music.stop()
	Sound.play(preload("uid://ccmys76n3sj17"))
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(1.0).timeout
	SceneLoader.change_scene(preload("uid://ddmjcvocbt7r1"))
	
	
	
	
