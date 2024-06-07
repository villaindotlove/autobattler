extends Modifier

var Value: int
var Priority = 1

func _modify_stat(target: Automaton) -> void:
	target.DamageModifiers[self] = {
		"function" : _modification_function,
		"priority" : Priority
	}

func _reverse_modification(target: Automaton) -> void:
	target.DamageModifiers.erase(self)

func _modification_function(stat):
	return stat + Value
