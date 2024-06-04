extends Node

enum Type {
	TARGETED,
	TARGETED_HOMING,
	STATIC
}

var Function = {
	Type.TARGETED: _process_targeted_movement,
	Type.TARGETED_HOMING: _process_homing_movement,
	Type.STATIC: _process_static_movement,
}

func _process_targeted_movement(spell: SpellInstance, delta: float) -> void:
	var step = spell.global_position.direction_to(spell.Target.global_position) * delta
	spell.global_position += step * spell.MissileSpeed
	

func _process_homing_movement(spell: SpellInstance, delta: float) -> void:
	spell.look_at(spell.Target.global_position)
	var step = spell.global_position.direction_to(spell.Target.global_position) * delta
	spell.global_position += step * spell.MissileSpeed

func _process_static_movement(_spell: SpellInstance, _delta: float) -> void:
	pass
