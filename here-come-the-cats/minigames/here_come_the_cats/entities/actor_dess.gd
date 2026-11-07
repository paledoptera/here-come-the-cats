extends Actor


@export var surfing: bool = false
var angle: float = 0.0
var pink: bool = false
var soul: SoulFriend
var current_anim: String
var animations_handled: bool = true

var last_hp: int = 0

func _ready() -> void:
	super()
	
	last_hp = Party.hero[0].hp
	Party.hero[0].hp_changed.connect(_on_damage)
	EventBus.damage_player.connect(_on_damage)
	if get_parent() is SoulFriend:
		soul = get_parent()
		EventBus.soul_mode_switched.connect(_on_soul_mode_switched)
	
	if surfing:
		$Rat.visible = true
	else:
		$Rat.visible = false
	
	

func _process(delta: float) -> void:
	if not surfing:
		return
	
	match $AnimationPlayer.current_animation:
		"switch_to_pink", "switch_to_yellow":
			animations_handled = false
		_:
			animations_handled = true
	
	if animations_handled:
		animate()

func animate() -> void:

	var input = Input.get_vector("left","right","up","down")
	
	var last_anim = current_anim
	
	var new_anim = last_anim

	if soul.soul_state == SoulFriend.SoulState.PINK:
		new_anim = "surfing_pink"
	else:
		if input == Vector2.ZERO:
			new_anim = "surfing"
		else:
			if input.x < 0.0 or input.y > 0.0:
				new_anim = "surfing_left"
			elif input.x > 0.0 or input.y < 0.0:
				new_anim = "surfing_right"
		
	if last_anim != new_anim:
		$AnimationPlayer.play(new_anim)

func _on_soul_mode_switched(mode: SoulFriend.SoulState):
	match mode:
		SoulFriend.SoulState.YELLOW:
			$AnimationPlayer.play("switch_to_yellow")
		SoulFriend.SoulState.PINK:
			$AnimationPlayer.play("switch_to_pink")
			

func _on_damage(new_hp: int) -> void:
	
	if new_hp < last_hp:
		$Damage.play("damage")
	elif new_hp > last_hp:
		$Damage.play("heal")
	
	last_hp = new_hp
