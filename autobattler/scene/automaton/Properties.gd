class_name Properties extends Node

@export var BaseDamage = 50.0
var DamageModifiers = {}
@export var Damage = BaseDamage
@export var BaseSpeed = 2.0
var SpeedModifiers = {}
@export var Speed = BaseSpeed
@export var BaseArmour = 10.0
var ArmourModifiers = {}
@export var Armour = BaseArmour
@export var BaseResist = 5.0
var ResistModifiers = {}
@export var Resist = BaseResist

func get_speed():
	return Speed

func update():
	if not DamageModifiers.is_empty():
		Damage = _calculate_modified_property(BaseDamage, DamageModifiers)
	if not SpeedModifiers.is_empty():
		Speed = _calculate_modified_property(BaseSpeed, SpeedModifiers)
	if not SpeedModifiers.is_empty():
		Armour = _calculate_modified_property(BaseArmour, ArmourModifiers)
	if not SpeedModifiers.is_empty():
		Resist = _calculate_modified_property(BaseResist, ResistModifiers)

func _calculate_modified_property(base_property: float, modifiers: Dictionary) -> float:
	var modifiers_in_order = []
	for key in modifiers.keys():
		if modifiers[key].priority == 1:
			modifiers_in_order.push_front(modifiers[key].function)
		else:
			modifiers_in_order.append(modifiers[key].function)
	var output = base_property
	for modifier_function in modifiers_in_order:
		output = modifier_function.call(output)
	return output
