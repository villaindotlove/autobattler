class_name Automaton extends Node3D

signal moved_to_new_tile
signal hp_changed
signal mana_changed
signal damaged
signal died

@export var MaxHealth = 100.0
@export var CurrentHealth = MaxHealth : set = _set_health
@export var MaxMana = 20
@export var CurrentMana = 0 : set = _set_mana
var ManaIncrement = 5

@export var Damage = 50.0
@export var Speed = 2.0

@export var IsEnemy = false
@export var IsMelee = true
@export var AttackHitbox: Resource
@export var SpellComponent: PackedScene
@onready var ControlTimer = $ControlTimer
@onready var MovementComponent = $MovementComponent
@onready var Model = $MonsterMesh
@onready var Clock = $Clock
@onready var LockTimer = $LockTimer
var ActiveSpell
var CurrentState = STATES.ACTIVE

var _motion_tw

enum STATES {
	ACTIVE,
	LOCKED,
	CONTROL,
	DEAD
}

func _ready():
	Model.attack_hitbox_begins.connect(_create_attack_hitbox)
	Model.attack_finished.connect(_end_attack_animation)
	MovementComponent.begin_attack.connect(_begin_attack_animation)
	MovementComponent.begin_move.connect(_create_motion_tween)
	var spell = SpellComponent.instantiate()
	add_child(spell)
	ActiveSpell = spell
	spell.cast_finished.connect(_on_cast_end)

func _update(_delta):
	pass

func damage(_value):
	CurrentHealth -= _value

func _set_health(value):
	hp_changed.emit(value)
	CurrentHealth = value
	if CurrentHealth <= 0:
		_die()

func _set_mana(value):
	mana_changed.emit(value)
	CurrentMana = value
	if CurrentMana >= MaxMana:
		_cast()

func _die():
	died.emit()
	queue_free()

func _create_motion_tween():
	look_at(MovementComponent.LocalTarget.position)
	MovementComponent.LocalTarget.occupied = true
	_motion_tw = get_tree().create_tween()
	_motion_tw.tween_property(self, "global_position", MovementComponent.LocalTarget.global_position, Speed * 0.9)
	_motion_tw.finished.connect(_end_move.bind(MovementComponent.LocalTarget))

func _end_move(target_tile):
	moved_to_new_tile.emit(target_tile)

func _begin_attack_animation(target):
	look_at(target.position)
	Model.play_attack_animation(Speed)
	CurrentState = STATES.LOCKED

func _end_attack_animation():
	if CurrentState == STATES.LOCKED:
		CurrentState = STATES.ACTIVE

func _create_attack_hitbox():
	var p = AttackHitbox.instantiate()
	p.hit.connect(_on_attack_hit)
	get_tree().root.add_child(p)
	p.global_position = global_position
	p.begin_motion(MovementComponent.Target)

func _on_attack_hit():
	CurrentMana += ManaIncrement

func _cast():
	CurrentState = STATES.LOCKED
#	Model.play_cast_animation()
	ActiveSpell.cast(MovementComponent.Target, global_position)

func _on_cast_end():
	CurrentState = STATES.ACTIVE
	CurrentMana = 0
