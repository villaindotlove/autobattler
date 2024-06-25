class_name AutoMesh extends Node3D

signal cast_finished
signal attack_hitbox_begins
signal attack_finished

@onready var _animation_player = $AnimationPlayer
@onready var _spawn_target = %Spawn

func _ready():
	_animation_player.animation_finished.connect(_on_animation_end)

func play_cast_animation(speed: float = 1.0) -> void:
	_animation_player.play("cast", -1, speed)

func play_attack_animation(speed: float = 1.0) -> void:
	_animation_player.play("attack", -1, speed)

func play_move_animation(speed: float = 1.0) -> void:
	_animation_player.play("move", -1, speed)

func get_spawn_location() -> Vector3:
	return _spawn_target.global_position

func _attack_hitbox_begins() -> void:
	attack_hitbox_begins.emit()

func _on_animation_end(_animation_name: String) -> void:
	match(_animation_name):
		"cast":
			cast_finished.emit()
		"attack":
			attack_finished.emit()
