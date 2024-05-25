class_name SpellComponent extends Node

signal cast_finished
signal aura_applied

@export var AuraEffect = []
@export var ParticleEffect: PackedScene
@export var Hitbox: PackedScene
@export var Buffs = []
@export var Debuffs = []
@export var Damage: int
@export var Healing: int
@export var Targets: Targeting.Type

func cast(primary_target, origin):
	var spell = _construct_spell()
	_fire_spell(spell, primary_target, origin)

func _construct_spell():
	var hitbox = Hitbox.instantiate()
	get_tree().root.add_child(hitbox)
	if ParticleEffect:
		var particle = ParticleEffect.instantiate()
		hitbox.add_child(particle)
	hitbox.Damage = Damage
	hitbox.Healing = Healing
	hitbox.TargetType = Targets
#	_apply_buffs(hitbox)
#	_apply_debuffs(hitbox)
	if AuraEffect:
		var aura = AuraEffect.instantiate()
		aura_applied.emit(aura)
	return hitbox

func _fire_spell(spell, target, origin):
	spell.Target = target
	spell.global_position = origin
	spell.begin()
	cast_finished.emit()

func _apply_buffs(spell):
	for buff in Buffs:
		spell.add_child(buff.instantiate())

func _apply_debuffs(spell):
	for debuff in Debuffs:
		spell.add_child(debuff.instantiate())
