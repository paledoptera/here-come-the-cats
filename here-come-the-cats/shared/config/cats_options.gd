class_name CatsOptions extends Resource

@export var no_hit_mode: bool = false:
	set(value):
		no_hit_mode = value
		if value:
			god_mode = false

@export var god_mode: bool = false:
	set(value):
		god_mode = value
		if value:
			no_hit_mode = false

@export var skip_prologue: bool = false
