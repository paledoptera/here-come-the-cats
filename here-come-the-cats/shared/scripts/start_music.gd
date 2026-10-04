class_name StartMusic extends Node

@export var song: AudioStream
@export var bpm: float = 120.0
@export var start_position: float = 0.0
@export var enable_rhythm_tracking: bool = false
@export var volume: float = 1.0

func _ready() -> void:
	Music.bpm = bpm
	Music.enable_rhythm = enable_rhythm_tracking
	Music.play(song,volume,start_position)
