extends Node


@export var talksound: AudioStream
var text: String
var visible_characters: float = 0.0
@onready var txt: RichTextLabel = get_parent()

func _process(delta: float) -> void:
	if text != txt.text:
		text = txt.text
		visible_characters = 0.0
	
	if not text:
		return
	
	
	if visible_characters != txt.visible_characters:
		visible_characters = txt.visible_characters
		
		var c := text[visible_characters - 1].to_ascii_buffer()[0]
		if DialogueBox.is_letter_or_number(c):
			Sound.play(talksound) 
