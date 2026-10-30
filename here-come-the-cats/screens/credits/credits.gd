extends Node

var able_to_leave: bool = false
var fading_out: bool = false

func _ready() -> void:
	Music.stop()

func _process(delta: float) -> void:
	if not able_to_leave:
		return
	
	
	
	
	if fading_out:
		return

	
	if Input.is_action_just_pressed("confirm") and not fading_out:
		fading_out = true
		var tween = create_tween()
		Sound.play(preload("res://shared/sound_effects/snd_select.wav"))
		tween.tween_property($Fader,"color",Color.BLACK,1.0)
		await tween.finished
		SceneLoader.goto_title()
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	able_to_leave = true
