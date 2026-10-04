extends Actor

var angle: float = 0.0
var pink: bool = false

func _process(delta: float) -> void:
	if pink:
		rotation = lerp_angle(rotation,get_parent().pink_angle,0.5)
		scale.x = get_parent().direction.x
	else:
		rotation = lerp_angle(rotation,0.0,0.24)
		scale.x = 1.0

func do_action(action: StringName):
	super(action)
	match action:
		"switch_to_yellow":
			pink = false
		"switch_to_pink":
			pink = true
