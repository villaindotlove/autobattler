extends Node

enum Type {
	TARGET,
	CLOSEST_E,
	CLOSEST_A,
	FURTHEST_E,
	FURTHEST_A,
#	RANDOM_E,
#	RANDOM_A,
	SELF
}

var Function = {
	Type.TARGET: _target_current_target,
	Type.CLOSEST_E: _target_closest_enemy,
	Type.CLOSEST_A: _target_closest_ally,
	Type.FURTHEST_E: _target_furthest_enemy,
	Type.FURTHEST_A: _target_furthest_ally,
	Type.SELF: _target_self
}

func _target_closest_enemy(is_enemy: bool, targeting_unit: Automaton) -> Automaton:
	var board = BoardReference.Instance
	var closest_unit = null
	var closest_distance = INF
	for unit in board.get_opposition_units(is_enemy):
		var dist = targeting_unit.global_position.distance_squared_to(unit)
		if targeting_unit.global_position.distance_squared_to(unit) < closest_distance:
			closest_unit = unit
			closest_distance = dist
	return closest_unit

func _target_furthest_enemy(is_enemy: bool, targeting_unit: Automaton) -> Automaton:
	var board = BoardReference.Instance
	var furthest_unit = null
	var furthest_distance = 0
	for unit in board.get_opposition_units(is_enemy):
		var dist = targeting_unit.global_position.distance_squared_to(unit)
		if targeting_unit.global_position.distance_squared_to(unit) > furthest_distance:
			furthest_unit = unit
			furthest_distance = dist
	return furthest_unit

func _target_closest_ally(is_enemy: bool, targeting_unit: Automaton) -> Automaton:
	var board = BoardReference.Instance
	var closest_unit = null
	var closest_distance = INF
	for unit in board.get_opposition_units(!is_enemy):
		var dist = targeting_unit.global_position.distance_squared_to(unit)
		if targeting_unit.global_position.distance_squared_to(unit) < closest_distance:
			closest_unit = unit
			closest_distance = dist
	return closest_unit

func _target_furthest_ally(is_enemy: bool, targeting_unit: Automaton) -> Automaton:
	var board = BoardReference.Instance
	var furthest_unit = null
	var furthest_distance = 0
	for unit in board.get_opposition_units(!is_enemy):
		var dist = targeting_unit.global_position.distance_squared_to(unit)
		if targeting_unit.global_position.distance_squared_to(unit) > furthest_distance:
			furthest_unit = unit
			furthest_distance = dist
	return furthest_unit

func _target_current_target(_is_enemy: bool, targeting_unit: Automaton) -> Automaton:
	var current_target = targeting_unit.get_current_target()
	return current_target

func _target_self(_is_enemy: bool, targeting_unit: Automaton) -> Automaton:
	return targeting_unit
