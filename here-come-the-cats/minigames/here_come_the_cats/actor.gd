extends Actor

func do_action(action: StringName):
	if current_action != action:
		animated_element.play("RESET")
	
	super(action)

func _action_finished(action_name: StringName):
	if action_name == "hurt":
		Actors.do_action("friend","idle")
		return
	super(action_name)
