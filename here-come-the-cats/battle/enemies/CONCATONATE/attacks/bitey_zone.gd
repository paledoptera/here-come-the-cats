extends Area2D

var soul: SoulFriend
var soul_in_zone: bool = false

const TEX1 = preload("uid://c77maolrlpf17")
const TEX2 = preload("uid://duiceukhldfat")


func _process(delta: float) -> void:
	if not soul or not soul_in_zone:
		return
	
	if soul.dashing:
		$AnimationPlayer.play("attack")

func _on_body_entered(body: Node2D) -> void:
	if body is Soul:
		soul = body
		soul_in_zone = true



func _on_body_exited(body: Node2D) -> void:
	if body is Soul:
		soul_in_zone = false
