extends Node2D


const CAT_COLLECTIBLE = preload("uid://c4xirgxvxcybl")


const CAT_ATTACKS_2_BEAT = [
	preload("uid://dd5aewx0bpt22"), # cat spit
	preload("uid://tgjgo8af01nh"), # cat shooter
	
]

const CAT_ATTACKS_4_BEAT = [
	preload("uid://clib1tg1p531h"), # cat tail
	preload("uid://bqpe6h8uay2lv"), # cat jaws
]

enum SoulType {YELLOW, PINK}



var repeating_attack_name: StringName = ""
var repeating_attack_amount: int = 0

var sound: int = 0
var soul: Soul
var beat: float = 0.0
@export var event: int = 0: set = _on_event_changed
@export var ticking_volume: float = 0.0
@export var attacking: bool = false

func _init() -> void:
	Party.enemy.clear()
	Party.hero.clear()
	Party.hero = [preload("uid://xcpu86gdep5b")] # hero_dess
	Party.enemy = [preload("uid://bwk0888uoya3f")] # enemy_friend
	

func _ready() -> void:
	Music.beat.connect(_on_beat)
	Music.song_ended.connect(_on_song_ended)
	EventBus.damage_player.connect(_damage_player)
	EventBus.coin_collected.connect(_on_coin_collected)
	await get_tree().create_timer(1.0).timeout
	#var line1 = DialogueString.new("Damn it!! \nMouse trap!")
	#line1.talksound = preload("res://shared/sound_effects/snd_txt_dess.wav")
	#line1.identifier = "dess"
	#line1.auto_skip = true
	#line1.require_input = true
	#line1.auto_skip_after = 3.0
	#Dialogue.display_text(line1)
	#await Dialogue.text_finished
	#Dialogue.clear_text.emit()

func _process(delta: float) -> void:
	if Party.enemy[0].hp <= 0.0:
		SceneLoader.change_scene(preload("uid://clyt0hcde7icu"))
		pass

func _on_beat() -> void:
	print("BEAT, ", Music.last_beat)
	beat += 1.0
	
	print("BEAT MOD, ", fmod(beat,3.0))
	
	

	
	if attacking == false:
		return
	
	if fmod(beat,8.0) == 0.0:
		start_attack(CAT_ATTACKS_4_BEAT.pick_random())
	elif fmod(beat,4.0) == 0.0:
		start_attack(CAT_ATTACKS_2_BEAT.pick_random())

		
		pass
	
	
	
		
	#
	#if beat >= 4.0:
		#beat -= 4.0
		#var chance = [false, false, true].pick_random()
		#if not chance:
			#return
		#
		#
		#var cat = CAT_COLLECTIBLE.instantiate()
		#add_child(cat)
		#cat.global_position.x = 700.0
		#cat.global_position.y = randf_range(0.0,480.0)


func _damage_player(value: int) -> void:
	Sound.play(preload("uid://cpo81emadro0k"))
	var target = Party.hero.pick_random()
	var damage = EnemyBulletFormula.calculate(value,Party.enemy[0],target)
	

	target.hp -= damage

	var damage_number = FloatingText.initialize_text(str(damage),Color.WHITE)
	Actors.trigger_damage_number(target.character_id,damage_number)

func _on_coin_collected() -> void:
	pass

func _on_event_changed(value: int) -> void:
	if event == value:
		return
	
	event = value
	
	
	match event:
		0: # start
			pass
		2: # clock active
			%DeathClock.activate()
		1: # cat anim
			$Background/TV/PerspectiveQuad2D/SubViewport/AnimatedSprite2D.play("default")
		50:
			%DeathClock.deactivate()
		666:
			Sound.play(preload("uid://dvms0telejmfp"))

func start_attack(attack: PackedScene):
	var pos = %Cat.global_position
	var inst = attack.instantiate()
	
	match inst.id.to_lower():
		"catjaws":
			pos = $SoulFriend.global_position
			pos.y = 0.0
			pos.x += randf_range(-100.0,100.0)
		"cattail":
			pos.x = 700.0
			pos.y = randf_range(150.0,300.0)
		"catshooter":
			pos.x = 700.0
		
	add_child(inst)
		
	inst.global_position = pos

	match inst.id.to_lower():
		"cattail":
			inst.look_at($SoulFriend.global_position)

func _on_song_ended() -> void:
	SceneLoader.change_scene(preload("uid://clyt0hcde7icu"))
