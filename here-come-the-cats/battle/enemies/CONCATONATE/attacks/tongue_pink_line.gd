extends "res://minigames/here_come_the_cats/pink_line.gd"

@export var speed: float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var link = get_child(0)
	var link_length: float = 0.0
	var curve_length: float = curve.get_baked_length()
	
	while link_length < curve_length:
		var new_link = link.duplicate()
		add_child(new_link)
		link_length += 20.0
		new_link.progress = link_length
		link = new_link
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in get_children():
		if i is PathFollow2D:
			i.progress += speed * delta
