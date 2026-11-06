extends Node2D


const CAT_COLLECTIBLE = preload("uid://c4xirgxvxcybl")

const DESS = preload("uid://xcpu86gdep5b")
const FRIEND = preload("uid://b1olkw8f4kqlm")

const CAT_ATTACKS = {
	"spit" = preload("uid://dd5aewx0bpt22"),
	"shooter" = preload("uid://tgjgo8af01nh"),
	"tail" = preload("uid://clib1tg1p531h"),
	"jaws" = preload("uid://bqpe6h8uay2lv"),
	"rats" = preload("uid://dayvcwnrmkmrw"),
	
}

enum SoulType {YELLOW, PINK}

var attack_progression: CatAttackProgression

var last_attack: StringName = "spit"
var repeating_attack_name: StringName = ""
var repeating_attack_amount: int = 0
var soul_in_biting_area: bool = false

var sound: int = 0
var soul: Soul
var beat: float = 0.0
@export var event: int = 0: set = _on_event_changed
@export var ticking_volume: float = 0.0
@export var attacking: bool = false

func _init() -> void:
	Party.enemy.clear()
	Party.hero.clear()
	Party.hero = [DESS.duplicate(true)] # hero_dess
	Party.enemy = [FRIEND.duplicate(true)] # enemy_concateny
	

func _ready() -> void:
	Party.tp = 0.0
	SceneLoader.game_state = SceneLoader.GameState.PHASE1
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
	Party.enemy[0].hp = clamp(Party.enemy[0].hp,962,2000)

func _on_beat() -> void:
	
	
	
	
	print("BEAT, ", Music.last_beat)
	beat += 1.0
	
	print("BEAT MOD, ", fmod(beat,3.0))
	
	

	
	if attacking == false:
		return
	
	
	if soul_in_biting_area:
		Actors.do_action("friend","chomp")
	else:
		Actors.do_action("friend","idle")
	
	
	
	var attack: CatAttack = attack_progression.attacks.pop_front()
	
	if attack is CatAttackWait:
		return
	elif attack is CatAttackSingle:
		start_attack(attack.attack)
	elif attack is CatAttackRandom:
		start_attack(attack.attack.pick_random())
	elif attack is CatAttackRepeat:
		start_attack(last_attack)


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
		3:
			attack_progression = preload("uid://da22bft76kvvq").duplicate(true)
		10: 
			attack_progression = preload("uid://ddou2lx2pflxc").duplicate(true)
		50:
			%DeathClock.deactivate()
		666:
			Sound.play(preload("uid://dvms0telejmfp"))

func start_attack(attack: StringName):
	var pos = %Cat.global_position
	
	var inst = CAT_ATTACKS[attack].instantiate()
	
	match attack:
		"spit":
			Actors.do_action("friend","spit")
		"jaws":
			Actors.do_action("friend","laugh")
			pos = $SoulFriend.global_position
			pos.y = 0.0
			pos.x += randf_range(-200.0,200.0)
		"tail":
			Actors.do_action("friend","aim")
			pos.x = 700.0
			pos.y = randf_range(150.0,300.0)
		"shooter":
			pos.x = 700.0
		"rats":
			pos.x = 700.0
	
	last_attack = attack
		
	add_child(inst)
		
	inst.global_position = pos

	match attack:
		"tail":
			inst.look_at($SoulFriend.global_position)

func _on_song_ended() -> void:
	SceneLoader.change_scene(preload("uid://clyt0hcde7icu"))


func _on_cat_soul_entered_bite_area() -> void:
	soul_in_biting_area = true


func _on_cat_soul_exited_bite_area() -> void:
	soul_in_biting_area = false
