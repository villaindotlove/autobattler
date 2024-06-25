class_name Automaton
extends Node3D

signal hp_changed
signal mana_changed
signal damaged
signal died
signal current_tile_changed

@export var MaxHealth = 100.0
@export var CurrentHealth = MaxHealth : set = _set_health
@export var MaxMana = 20
@export var CurrentMana = 0 : set = _set_mana
var ManaIncrement = 5

@export var IsEnemy = false
@export var IsMelee = true

@onready var Attributes = Properties.new()
@export var AttackHitbox: Resource
@onready var Model = $WiseMage
@export var ActiveSpell: Spell

var CurrentTile: Tile
var target: Automaton

var _motion_tw

func _ready():
	pass
	#Model.attack_hitbox_begins.connect(_create_attack_hitbox)
	#Model.cast_finished.connect(_on_cast_end)
	#targetComponent.begin_attack.connect(_begin_attack_animation)
	#targetComponent.begin_move.connect(_create_motion_tween)

func set_current_tile(tile: Tile) -> void:
	CurrentTile.occupied = false
	CurrentTile = tile
	current_tile_changed.emit()

func get_current_tile():
	return CurrentTile

func set_current_target(target_unit: Automaton):
	target = target_unit

func get_current_target():
	return target

func damage(value):
	CurrentHealth -= value
	damaged.emit(value)

func heal(value):
	CurrentHealth += value

func _set_health(value):
	CurrentHealth = value
	hp_changed.emit(value)
	if CurrentHealth <= 0:
		_die()

func _set_mana(value):
	CurrentMana = value
	mana_changed.emit(value)

func _die():
	died.emit()

func _on_attack_hit():
	CurrentMana += ManaIncrement

func _on_cast_end():
	CurrentMana = 0
