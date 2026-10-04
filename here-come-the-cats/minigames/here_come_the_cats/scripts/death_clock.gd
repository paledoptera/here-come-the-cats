class_name DeathClock extends Node2D

enum ClockState { BELL, IDLE, DANGEROUS, DEATH}
var active: bool = false
var ticking_volume: float = 1.0
var time_left: float = -135.0
var sound: int = 0
var state:= ClockState.BELL


func _ready() -> void:
	Music.beat.connect(_on_beat)
	EventBus.coin_collected.connect(_on_coin_collected)

func _process(delta: float) -> void:
	if not active:
		$Whirring.playing = false
		return
		
	match state:
		ClockState.DANGEROUS:
			if $Whirring.playing == false:
				$Whirring.playing = true
			$Whirring.pitch_scale = ticking_volume/4
			$Whirring.volume_linear = lerp($Whirring.volume_linear,0.7,0.01)
		_:
			$Whirring.playing = false
			$Whirring.pitch_scale = 0.01
			$Whirring.volume_linear = 0.0
	%Clock.rotate(-0.05)

func _on_beat() -> void:
	if not active:
		return
	
	match state:
		ClockState.BELL:
			time_left = clampf(time_left-45.0,-180.0,0.0)
			Sound.play(preload("res://shared/sound_effects/snd_cat_bell.wav"))
			ticking_volume = 1.0
			state = ClockState.IDLE
			
		ClockState.IDLE:
			ticking_volume = lerp(ticking_volume,0.0,0.1)
			time_left = clampf(time_left+2.25,-180.0,0.0)
			if time_left > -30:
				state = ClockState.DANGEROUS
		
		ClockState.DANGEROUS:
			
			time_left = clampf(time_left+2.25,-180.0,0.0)
			ticking_volume = lerp(ticking_volume,1.0,0.2)
			Sound.play(preload("res://shared/sound_effects/snd_meow.wav"),ticking_volume,0.5+(ticking_volume/2))
			
	
	print("TIME LEFT: ", time_left)
	
	if ticking_volume > 0.0:
		var sound_eff = preload("uid://bllvy088nfet1")
		if sound == 1:
			sound_eff = preload("uid://xg82w7g347q0")
		
		Sound.play(sound_eff,ticking_volume*0.5,0.9)
		sound = wrapi(sound+1,0,2)
	
	%Hand.rotation_degrees = time_left
	#Sound.play(preload("uid://dqdqlcl363j8h"),0.7)

func activate() -> void:
	active = true
	state = ClockState.BELL
	$Actions.play("activate")

func _on_coin_collected() -> void:
	state = ClockState.BELL
	_on_beat()
