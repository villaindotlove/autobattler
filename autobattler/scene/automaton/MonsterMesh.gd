extends Node3D

signal attack_hitbox_begins
signal attack_finished

@onready var _anim_player = %AnimationPlayer

func play_attack_animation(_speed):
	_anim_player.play("attack")

func _start_attack_hitbox():
	attack_hitbox_begins.emit()

func _end_attack():
	attack_finished.emit()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		_end_attack()
