class_name MoveComponent extends Node3D

signal begin_move
signal move_completed
signal begin_attack

@onready var ParentUnit = get_parent()
var Target = null
var AttackRange = 7.0
var CurrentTile: Tile
var LocalTarget: Tile
var _target_tile: Tile
var _motion_tw: Tween
var _current_route = []

func _ready():
	_initialise.call_deferred()

func _initialise():
	ParentUnit.Clock.timeout.connect(_on_clock_timeout)
	ParentUnit.moved_to_new_tile.connect(_on_moved_to_new_tile)

func _on_clock_timeout():
	if _calculate_distance(CurrentTile, Target.MovementComponent.CurrentTile) <= AttackRange:
		begin_attack.emit(Target)
		return
	assign_closest_target(BoardReference.Instance.get_opposition_units(ParentUnit.IsEnemy))
	if Target:
		if Target.MovementComponent.CurrentTile != _target_tile or (LocalTarget and LocalTarget.occupied):
			_current_route = Pathfinding.a_star(CurrentTile, Target.MovementComponent.CurrentTile)
			if _current_route and _current_route.size() > 1:
				LocalTarget = _current_route[1]
			else:
				LocalTarget = null
	if LocalTarget:
		begin_move.emit()

func _on_moved_to_new_tile(tile: Tile):
	CurrentTile.occupied = false
	CurrentTile = LocalTarget
	if _current_route.size() > 1:
		LocalTarget = _current_route[1]

func reassign_target_if_invalid():
	if Target == null or not is_in_range_of_target():
		assign_closest_target(BoardReference.Instance.get_opposition_units(ParentUnit.IsEnemy))

func assign_closest_target(valid_targets) -> void:
	valid_targets.sort_custom(_sort_by_distance)
	for target in valid_targets:
		var shortest_path = Pathfinding.a_star(CurrentTile, target.MovementComponent.CurrentTile)
		if _calculate_distance(shortest_path.back(), target.MovementComponent.CurrentTile) <= AttackRange:
			Target = target
			return
	Target = null

func is_in_range_of_target() -> bool:
	if Target == null:
		return true
	if _calculate_distance(Target.tile, CurrentTile) <= AttackRange:
		return true
	else:
		return false

func _calculate_distance(t1, t2):
	return abs(t1.coord.x - t2.coord.x) + abs(t1.coord.y - t2.coord.y)

func _sort_by_distance(a, b):
	var a_tile = a.MovementComponent.CurrentTile
	var b_tile = b.MovementComponent.CurrentTile
	var a_dist = _calculate_distance(a_tile, CurrentTile)
	var b_dist = _calculate_distance(b_tile, CurrentTile)
	return a_dist < b_dist
