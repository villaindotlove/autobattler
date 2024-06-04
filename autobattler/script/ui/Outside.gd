extends Control

func _can_drop_data(at_position, data):
	var control = Control.new()
	var u = data.unit.Unit.instantiate()
	u.global_position = DragUnit.get_mouse_world_position()
	control.add_child(u)
	set_drag_preview(control)
	return true

func _drop_data(at_position, data):
	get_tree().root.add_child(data.unit.Unit.instantiate())
