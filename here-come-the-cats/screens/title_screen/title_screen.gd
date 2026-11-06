extends Node

var started: bool = false

func _ready() -> void:
	Global.save_file.load_data()

	
	if Global.save_file.completed:
		%Extras.modulate = Color.WHITE
		%Extras.disabled = false
	else:
		%Extras.modulate = Color("6c6c6c")
		%Extras.disabled = true

	$ExtrasMenu.visible = false

	await get_tree().create_timer(4.0).timeout
	$MenuInputManager.open_menu($Options)


func _on_option_selected(index: int) -> void:
	match index:
		0: # Start
			Music.fade_out(2.0)
			started = true
			$Soul.visible = false
			$MenuInputManager.close_all_menus()
			$AnimationPlayer.play("fade_out")
			await get_tree().create_timer(3.0).timeout
			if Global.options.skip_prologue:
				SceneLoader.change_scene(preload("uid://ddmjcvocbt7r1"))
			else:
				SceneLoader.change_scene(preload("uid://wfktweg8on8i"))
		1: # Extras
			extras_gameplay_refresh()
			$ExtrasMenu.visible = true
			$MenuInputManager.open_menu(%Gameplay)
		2: # Quit
			get_tree().quit()
	pass # Replace with function body.

func _on_extras_options_hovered(index: int) -> void:
	for i in %ExtrasOptions.get_children():
		i.modulate = Color.WHITE
		if i.get_index() == index:
			i.modulate = Color.YELLOW
		

func _on_extras_option_selected(index: int) -> void:
	match index:
		0: # Gameplay
			$MenuInputManager.open_menu(%Gameplay)
			pass
		1: # Back to title
			$MenuInputManager.close_menu()


func _on_gameplay_option_hovered(index: int) -> void:
	for i in %Gameplay.get_children():
		i.modulate = Color.WHITE
		if i.get_index() == index:
			i.modulate = Color.YELLOW

func extras_gameplay_refresh() -> void:
	for i in %Gameplay.get_children():
		if i.name == "Godmode":
			i.get_node("Checkbox").frame = int(Global.options.god_mode)
		elif i.name == "NoHitMode":
			i.get_node("Checkbox").frame = int(Global.options.no_hit_mode)
		elif i.name == "SkipPrologue":
			i.get_node("Checkbox").frame = int(Global.options.skip_prologue)
		
func _on_gameplay_options_selected(index: int) -> void:
	match index:
		0: # God mode
			Global.options.god_mode = not Global.options.god_mode
		1: # No hit mode
			print("SHIT")
			Global.options.no_hit_mode = not Global.options.no_hit_mode
		2: # Skip prologue
			Global.options.skip_prologue = not Global.options.skip_prologue
	
	extras_gameplay_refresh()
	pass # Replace with function body.
