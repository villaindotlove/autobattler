extends PanelContainer

var Unit

func _ready():
	if get_child_count() > 0:
		Unit = get_child(0)

func _get_drag_data(at_position):
	if get_child_count() > 0:
		var preview = Unit.duplicate(0)
		set_drag_preview(preview)
		var data = {
			unit = Unit
		}
		return data

func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	data.unit.get_parent().Unit = Unit
	Unit = data.unit
	data.unit.reparent(self)
