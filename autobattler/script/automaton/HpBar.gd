extends TextureProgressBar

var Max : set = _set_max
var Current : set = _set_current

func _on_automaton_hp_changed(new_value):
	Current = new_value

func _set_current(_value):
	value = _value

func _set_max(_value):
	max_value = _value
