class_name BeatSyncedAnimationPlayer extends AnimationPlayer

var fallback_speed: float = 1.0
var playing_fallback: bool = false
var beat = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fallback_speed = speed_scale
	speed_scale = 0.0
	Music.beat.connect(_on_beat)

func _process(delta: float) -> void:
	
	if not Music.current_song:
		if not playing_fallback:
			playing_fallback = true
			play(current_animation)
			speed_scale = fallback_speed
		return
	
	var progress = Music.beat_progress
	seek(progress+beat,true)
	#print("MMUSIC PROGRESS: ", progress+beat)

func _on_beat() -> void:
	beat += 1.0
