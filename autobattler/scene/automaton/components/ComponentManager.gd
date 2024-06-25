class_name ComponentManager
extends Node

@onready var auto_clock = $AutoClock
var parent: Automaton
var components = []

func _ready():
	parent = get_parent()
	for component in get_children():
		components.append(component)
		component.set_parent(parent)
		component.manager = self

func connect_to_clock(function: Callable) -> void:
	auto_clock.clock_timeout.connect(function)
