extends StaticBody3D

signal received_object

func drop_object(object):
	var tween = get_tree().create_tween()
	tween.tween_property(object, "position", self.global_position, 0.1).set_ease(Tween.EASE_OUT)
	received_object.emit(object, get_parent())
