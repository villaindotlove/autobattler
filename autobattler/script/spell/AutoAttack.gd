extends MeshInstance3D

signal hit

@export var Speed = 10.0
@export var Damage = 5.0
var _target

func begin_motion(target):
	_target = target
	look_at(_target.position)

func _process(delta):
	var direction = _target.position - position
	direction = direction.normalized()
	position += direction * Speed * delta

func _on_collision_enter(_area):
	var unit_hit = _area.get_parent()
	if unit_hit == _target:
		unit_hit.damage(Damage)
		hit.emit()
		queue_free()
