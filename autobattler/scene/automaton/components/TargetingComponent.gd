class_name TargetingComponent extends Node

signal begin_move
signal move_completed
signal begin_attack

var unit: Automaton
var manager: ComponentManager

var Target = null
var AttackRange = 7.0
var CurrentTile: Tile
var local_target: Tile
var _target_tile: Tile
var _current_route = []

func _ready():
	_initialise.call_deferred()

func _initialise():
	manager.connect_to_clock(_on_clock_timeout)
	unit.moved_to_new_tile.connect(_on_moved_to_new_tile)

func _on_clock_timeout():
	if _calculate_distance(CurrentTile, Target.MovementComponent.CurrentTile) <= AttackRange:
		begin_attack.emit(Target)
		return
	assign_closest_target(BoardReference.Instance.get_opposition_units(unit.IsEnemy))
	if Target:
		if Target.CurrentTile != _target_tile or (local_target and local_target.occupied):
			_current_route = Pathfinding.a_star(CurrentTile, Target.CurrentTile)
			if _current_route and _current_route.size() > 1:
				local_target = _current_route[1]
			else:
				local_target = null
	if local_target:
		begin_move.emit()

func _on_moved_to_new_tile():
	unit.set_current_tile(local_target)
	if _current_route.size() > 1:
		local_target = _current_route[1]

func reassign_target_if_invalid():
	if Target == null or not is_in_range_of_target():
		assign_closest_target(BoardReference.Instance.get_opposition_units(unit.IsEnemy))

func assign_closest_target(valid_targets) -> void:
	valid_targets.sort_custom(_sort_by_distance)
	for target in valid_targets:
		var shortest_path = Pathfinding.a_star(unit.CurrentTile, target.CurrentTile)
		if _calculate_distance(shortest_path.back(), target.CurrentTile) <= AttackRange:
			Target = target
			return
	Target = null

func is_in_range_of_target() -> bool:
	if Target == null or _calculate_distance(Target.tile, CurrentTile) <= AttackRange:
		return true
	else:
		return false

func set_parent(parent: Automaton) -> void:
	unit = parent

func _calculate_distance(t1, t2):
	return abs(t1.coord.x - t2.coord.x) + abs(t1.coord.y - t2.coord.y)

func _sort_by_distance(a, b):
	var a_tile = a.MovementComponent.CurrentTile
	var b_tile = b.MovementComponent.CurrentTile
	var a_dist = _calculate_distance(a_tile, CurrentTile)
	var b_dist = _calculate_distance(b_tile, CurrentTile)
	return a_dist < b_dist
