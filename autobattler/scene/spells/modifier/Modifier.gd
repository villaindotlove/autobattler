class_name Modifier extends Node

var Duration
var _target_unit
var _duration_timer

func begin_stat_modification(target: Automaton):
	_duration_timer = Timer.new()
	_duration_timer.wait_time = Duration
	_duration_timer.timeout.connect(end_modification)
	_target_unit = target
	_modify_stat(_target_unit)

func end_modification():
	_reverse_modification(_target_unit)
	queue_free()

func _modify_stat(target: Automaton) -> void:
	pass

func _reverse_modification(target: Automaton) -> void:
	pass

func _modification_function(stat):
	pass
