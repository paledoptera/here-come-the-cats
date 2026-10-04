extends Node2D


const CAT_COLLECTIBLE = preload("uid://c4xirgxvxcybl")

const SOUL: Dictionary[SoulType,PackedScene] = {
	SoulType.YELLOW : preload("uid://cid2axpbkqulk"), 
	SoulType.PINK : preload("uid://dpamn6vphyrlm"),
	}

enum SoulType {YELLOW, PINK}



var sound: int = 0
var soul: Soul
var beat: float = 0.0
@export var event: int = 0: set = _on_event_changed
@export var ticking_volume: float = 0.0

func _init() -> void:
	Party.enemy.clear()
	Party.hero.clear()
	Party.hero = [preload("uid://xcpu86gdep5b")] # hero_dess
	Party.enemy = [preload("uid://bwk0888uoya3f")] # enemy_friend

func _ready() -> void:
	Music.beat.connect(spawn_cat_collectible)
	EventBus.damage_player.connect(_damage_player)
	EventBus.coin_collected.connect(_on_coin_collected)
	await get_tree().create_timer(1.0).timeout
	var line1 = DialogueString.new("Damn it!! \nMouse trap!")
	line1.talksound = preload("res://shared/sound_effects/snd_txt_dess.wav")
	line1.identifier = "dess"
	line1.auto_skip = true
	line1.require_input = true
	line1.auto_skip_after = 3.0
	Dialogue.display_text(line1)
	await Dialogue.text_finished
	Dialogue.clear_text.emit()

func _process(delta: float) -> void:
	if Party.enemy[0].hp <= 0.0:
		SceneLoader.change_scene(preload("uid://byl3bkak2eqx5"))
		pass

func spawn_cat_collectible() -> void:
	print("BEAT, ", Music.last_beat)
	beat += 1.0
	
		
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

func change_soul_type(type: SoulType):
	var soul_position:= Vector2(216,243)
	if soul:
		soul_position = soul.position
		soul.queue_free()
	soul = SOUL[type].instantiate()
	add_child(soul)


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
		1: # clock active
			%DeathClock.activate()
			
