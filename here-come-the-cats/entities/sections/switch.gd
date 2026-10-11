class_name Switch extends Area2D



@export var linked_contraptions: Array[Node2D]
@export var one_shot: bool = false
var on: bool = false

var triggered: bool = false

func trigger():
	if one_shot and triggered:
		return
	triggered = true
	on = not on
	
	if on:
		$AnimationPlayer.play("switch_to_on")
	else:
		$AnimationPlayer.play("switch_to_off")
	Sound.play(preload("res://shared/sound_effects/snd_noise.wav"))

	if linked_contraptions:
		for i in linked_contraptions:
			if i:
				i.on = on
