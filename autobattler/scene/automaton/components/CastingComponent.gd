class_name CastingComponent extends Node

signal cast_finished
signal aura_applied

@export var ActiveSpell: Spell
@onready var _spell_factory: SpellFactory = SpellFactory.new()

var _on_hit_proc: SpellInstance
var _on_duration_proc: SpellInstance
var _on_cast_proc: SpellInstance

func cast(pos: Vector3) -> void:
	var casting_unit = get_parent()
	var main_spell_instance = _spell_factory.create_spell_instance(ActiveSpell, casting_unit.IsEnemy)
	if ActiveSpell.OnCastProc:
		_on_cast_proc = _spell_factory.create_spell_instance(ActiveSpell.OnCastProc, casting_unit.IsEnemy)
	if ActiveSpell.OnHitProc:
		_on_hit_proc = _spell_factory.create_spell_instance(ActiveSpell.OnHitProc, casting_unit.IsEnemy)
	if ActiveSpell.DurationProc:
		_on_duration_proc = _spell_factory.create_spell_instance(ActiveSpell.DurationProc, casting_unit.IsEnemy)
	main_spell_instance.spell_hit.connect(_on_spell_hit)
	get_tree().root.add_child(main_spell_instance) 
	main_spell_instance.global_position = pos
	main_spell_instance.cast(pos, casting_unit)
#	_on_cast_proc.cast(pos, casting_unit)
	cast_finished.emit()

func _on_spell_hit(pos: Vector3):
	get_tree().root.add_child(_on_hit_proc) 
	_on_hit_proc.cast(pos, get_parent())

