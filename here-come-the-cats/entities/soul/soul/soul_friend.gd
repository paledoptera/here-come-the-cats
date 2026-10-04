class_name SoulFriend extends Soul

enum ShootState {IDLE, CHARGING, SHOOT}
enum SoulState {YELLOW, PINK}

var soul_state := SoulState.YELLOW



@export var direction := Vector2.RIGHT
var shoot_state := ShootState.IDLE
var charge_max: float = 16.0
var charge_timer: float = 0.0
var dash_timer: float = 0.0
var dash_timer_target: float = 0.0
var dash_timer_max_visual: float = 0.0
var dash_flash: float = 0.0
var dash_flash_max: float = 0.0
var buffer: float = 0.33
var dash_momentum: float = 0.0
var dashing: bool = false


var pink_lines: Array[Node]
var pink_followers: Array[Node]
var pink_line: Path2D
var pink_angle: float = 0.0
var pink_follower: PathFollow2D
var pink_percent: float = 0.0
var can_flip_to_pink: bool = false
var shoot_buffer: float = 0.0

@onready var pink_outline: Sprite2D = $SwitchOutline
var active: bool = true

func _ready() -> void:
	super()
	
	setup_pink()


func _physics_process(delta: float) -> void:
	
	var h_input = Input.get_axis("left","right")
	if h_input != 0.0:
		direction.x = h_input
	
	Party.tp = clampf(Party.tp,0.0,100.0)
	
	if pink_follower:
		pink_angle = pink_follower.rotation

		
	
	match soul_state:
		SoulState.YELLOW:
			$Sprite2D/HeartbeatEffect/HeartbeatAnim.speed_scale = 0.3
			pink_percent = move_toward(pink_percent,0.0,delta * 2.0)
			handle_shoot(delta)
			speed_mult = 2.0
			momentum = 0.2
			slerp = false
			super(delta)
		SoulState.PINK:
			$Sprite2D/HeartbeatEffect/HeartbeatAnim.speed_scale = 0.7
			
			shoot_state = ShootState.IDLE
			pink_percent = move_toward(pink_percent,1.0,delta * 2.0)
			
			slerp = true
			super(delta)
			
			var line = pink_follower.get_parent()
			var offset = line.curve.get_closest_offset(line.to_local(global_position))
			pink_follower.progress = offset
			pink_follower.force_update_transform()
			speed_mult = 2.0
			handle_dash(delta)

	
	if soul_state == SoulState.PINK:
		global_position = global_position.lerp(pink_follower.global_position,pink_percent)
		pink_outline.modulate = Color.TRANSPARENT
		
	if Input.is_action_just_pressed("menu"):
		switch_soul_mode()


	if dashing:
		$PinkParticles.emitting = true
		$Sprite2D/HeartbeatEffect.modulate = $Sprite2D/HeartbeatEffect.modulate.lerp(Color.WHITE,0.5)
		$Flash.modulate = $Flash.modulate.lerp(Color.WHITE,0.1)
	else:
		$PinkParticles.emitting = false
		$Sprite2D/HeartbeatEffect.modulate = $Sprite2D/HeartbeatEffect.modulate.lerp(Color.TRANSPARENT,0.1)
		$Flash.modulate = $Flash.modulate.lerp(Color.TRANSPARENT,0.5)

	
	

func _process(delta: float) -> void:
	if soul_state == SoulState.YELLOW:
		process_pink_switcher()
	
	if global_position.distance_to(pink_follower.global_position) > 32.0:
		pink_outline.modulate = pink_outline.modulate.lerp(Color.TRANSPARENT,0.2)
	else:
		pink_outline.modulate = pink_outline.modulate.lerp(Color.WHITE,0.2)
	

func handle_shoot(_delta: float) -> void:
	dashing = false
	if shoot_state == ShootState.IDLE:
		charge_timer = 0.0
		if Input.is_action_just_pressed("confirm"):
			shoot_buffer = 1.0
		if Input.is_action_pressed("confirm"):
			shoot_buffer -= 0.2
			if shoot_buffer <= 0.0 and Party.tp >= 8.0:
				shoot_state = ShootState.CHARGING
		$Flash.modulate = Color.TRANSPARENT
		$Sprite2D/HeartbeatEffect.modulate = Color.TRANSPARENT
		
	elif shoot_state == ShootState.CHARGING:
		if charge_timer < 16.0 and Party.tp > 1.1:
			Party.tp -= 0.5
			charge_timer = move_toward(charge_timer, 16.0, 0.5);
		if Party.tp <= 0.0:
			shoot_state = ShootState.SHOOT
		$Flash.modulate = Color.TRANSPARENT.lerp(Color.WHITE,ease(charge_timer/16.0,1.5))
		
		if charge_timer == 16.0:
			$Sprite2D/HeartbeatEffect.modulate = $Sprite2D/HeartbeatEffect.modulate.lerp(Color.WHITE,0.3)
		
	if Input.is_action_just_released("confirm") and Party.tp >= 0.0:
		shoot_state = ShootState.SHOOT
	
	if shoot_state == ShootState.SHOOT:
		shoot_state = ShootState.IDLE
		
		
		var bullet: Area2D
		
		if charge_timer < 16.0:
			Sound.play(preload("res://shared/sound_effects/snd_fire.wav"), 0.15)
			bullet = preload("uid://d3mehrs4xv7gp").instantiate()
			Party.tp -= 1.0
			velocity += Vector2(-250.0,0.0)
		else:
			Sound.play(preload("res://shared/sound_effects/snd_chargeshot_fire.wav"),0.5)
			bullet = preload("uid://bfm3dcc03i7v7").instantiate()
			velocity += Vector2(-1000.0,0.0)
		get_parent().add_child(bullet)
		bullet.global_position = global_position


func switch_soul_mode() -> void:
	

	
	if soul_state == SoulState.YELLOW:
		if global_position.distance_to(pink_follower.global_position) > 32.0:
			Sound.play(preload("res://shared/sound_effects/snd_bump.wav"))
			return
	
	Sound.play(preload("res://shared/sound_effects/snd_petaldrain.wav"))
	Sound.play(preload("res://shared/sound_effects/snd_smallswing.wav"))
	

	soul_state = wrapi(soul_state+1,0,2)

	if soul_state == SoulState.YELLOW:
		Actors.do_action("dess","switch_to_yellow")
		$AnimationPlayer.play("switch_to_yellow")
		charge_timer = 0.0
	else:
		Actors.do_action("dess","switch_to_pink")
		$AnimationPlayer.play("switch_to_pink")
		charge_timer = 0.0

func handle_dash(delta: float) -> void:
	if Input.is_action_pressed("confirm"):
		
		speed_mult = 6.0
		momentum = 0.2
		if target_velocity != Vector2.ZERO:
			dashing = true
			Party.tp += 1.0

		else:
			dashing = false
		
		
	else:
		dashing = false
		
		momentum = 1.0
		
	

func setup_pink() -> void:
	pink_lines = get_tree().get_nodes_in_group("pink_lines")
	
	for i in pink_lines:
		var follower = PathFollow2D.new()
		i.add_child(follower)
		pink_followers.append(follower)
	

	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass # Replace with function body.

func process_pink_switcher() -> void:
	
	var nearest_distance: float = 99999.0
	var nearest_follower: PathFollow2D
	
	for follower in pink_followers:
		var line = follower.get_parent()
		var offset = line.curve.get_closest_offset(line.to_local(global_position))
		follower.progress = offset
		follower.force_update_transform()
		
		var distance = global_position.distance_squared_to(follower.global_position)
		if distance < nearest_distance:
			nearest_follower = follower
			nearest_distance = distance
	
	pink_follower = nearest_follower
	
	
	if pink_outline and nearest_follower:
		
		pink_outline.reparent(nearest_follower,false)
		
