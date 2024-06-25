extends Node

signal moved_to_new_tile

var unit: Automaton
var target_component: TargetingComponent

var _motion_tw: Tween

func _ready():
	call_deferred(_initialise)

func _create_motion_tween():
	var target_tile = target_component.LocalTarget
	unit.look_at(target_tile.position)
	target_tile.occupied = true
	_motion_tw = get_tree().create_tween()
	_motion_tw.tween_property(unit, "global_position", target_tile.global_position, unit.get_speed() * 0.9)
	_motion_tw.finished.connect(_move_completed)

func _move_completed():
	moved_to_new_tile.emit()

func _initialise():
	target_component = 
