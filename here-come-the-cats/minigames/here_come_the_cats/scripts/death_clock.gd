class_name DeathClock extends Node2D

signal impending_doom

enum ClockState { BELL, IDLE, DANGEROUS, DEATH}
var active: bool = false
var ticking_volume: float = 1.0
var time_left: float = -135.0
var sound: int = 0
var state:= ClockState.IDLE
var clock_size:= Vector2.ONE


func _ready() -> void:
	Music.beat.connect(_on_beat)
	EventBus.coin_collected.connect(_on_small_coin_collected)
	EventBus.large_coin_collected.connect(_on_coin_collected)

func _process(delta: float) -> void:
	if not active or time_left == 0.0:
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
	$Offset.scale = $Offset.scale.lerp(clock_size,0.05)

func _on_beat() -> void:
	if not active:
		return
	
	if time_left == 0.0:
		Sound.play(preload("res://shared/sound_effects/snd_meow.wav"),ticking_volume,0.5+(ticking_volume/2))
		Sound.play(preload("uid://6h3yan5cx6ek"),2.0)
		
		if Party.hero[0].hp <= 50.0 and not Global.options.god_mode:
			Global.cause_of_death = "cat_clock"
			Sound.play(preload("uid://bllvy088nfet1"),2.0)
			Sound.play(preload("uid://bsgom8dbhcrsr"),0.5,1.2)
			SceneLoader.goto_gameover()
		
		else:
			EventBus.damage_player.emit(randf_range(6.0,7.0))
		return
	
	match state:
			
		ClockState.IDLE:
			ticking_volume = lerp(ticking_volume,0.0,0.1)
			time_left = clampf(time_left+2.25,-180.0,0.0)
			clock_size = Vector2.ONE
			if time_left > -30:
				state = ClockState.DANGEROUS
		
		ClockState.DANGEROUS:
			impending_doom.emit()
			clock_size += Vector2(0.04,0.04)
			clock_size = clock_size.clamp(Vector2(1.0,1.0),Vector2(1.5,1.5))
			time_left = clampf(time_left+2.25,-180.0,0.0)
			ticking_volume = lerp(ticking_volume,1.0,0.3)
			Sound.play(preload("res://shared/sound_effects/snd_meow.wav"),ticking_volume,0.5+(ticking_volume/2))
			if time_left < -30:
				state = ClockState.IDLE
	

	
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
	state = ClockState.IDLE
	Sound.play(preload("res://shared/sound_effects/snd_cat_bell.wav"))
	$Actions.play("activate")

func deactivate() -> void:
	active = false
	$Actions.play_backwards("activate")

func _on_coin_collected() -> void:
	time_left = clampf(time_left-45.0,-180.0,0.0)
	Sound.play(preload("res://shared/sound_effects/snd_cat_bell.wav"))
	ticking_volume = 1.0
	_on_beat()
	
func _on_small_coin_collected() -> void:
	time_left = clampf(time_left-15.0,-180.0,0.0)
	Sound.play(preload("res://shared/sound_effects/snd_coin.wav"),0.5,randf_range(0.5,1.5))
	ticking_volume += 0.3
	ticking_volume = min(ticking_volume,1.0)
	_on_beat()
	
