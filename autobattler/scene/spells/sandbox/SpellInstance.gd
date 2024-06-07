class_name SpellInstance extends Node3D

signal spell_hit
signal duration_expired

var Damage: int
var Healing: int
var MissileSpeed: float
var Pierce: int
var IsEnemy: bool

var TargetingFunction
var MovementFunction

var Target: Automaton
var _hit_targets = {}
var _active = false

func cast(spawn_pos: Vector3, casting_unit: Automaton) -> void:
	position = spawn_pos
	_active = true
	Target = TargetingFunction.call(IsEnemy, casting_unit)

func _process(delta):
	if not _active:
		return
	MovementFunction.call(self, delta)

func _on_duration_timeout() -> void:
	duration_expired.emit()

func on_collision_enter(area: Area3D) -> void:
	var unit_hit = area.get_parent()
	if Pierce == 0:
		if is_instance_valid(Target):
			if unit_hit == Target:
				_process_hit(unit_hit)
				queue_free()
	else:
		if not unit_hit is Automaton:
			return
		if not _hit_targets.has(unit_hit):
			_process_hit(unit_hit)
			_hit_targets[unit_hit] = true
		if Pierce > 0:
			Pierce -= 1
			if Pierce == 0:
				queue_free()

func _process_hit(unit: Automaton) -> void:
	unit.damage(Damage)
	unit.heal(Healing)
	spell_hit.emit(global_position)
