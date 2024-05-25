@tool extends Area3D

@export var Homing: bool
@export var Damage: int
@export var Healing: int
@export var Speed = 10.0
@export var TargetType: Targeting.Type
@export var Target: Node3D
@export var x_size = 1.0 : set = _set_x
@export var y_size = 1.0 : set = _set_y
@export var z_size = 1.0 : set = _set_z

@onready var shape = $CollisionShape3D
var _ready = false

func _set_x(value):
	x_size = value
	shape.shape.size.x = value

func _set_y(value):
	y_size = value
	shape.shape.size.y = value

func _set_z(value):
	z_size = value
	shape.shape.size.z = value

func begin():
	_ready = true

func _process(delta):
	if Engine.is_editor_hint() or not _ready:
		return
	if not is_instance_valid(Target):
		queue_free()
		return
	if Homing:
		look_at(Target.position)
	var dir = Target.global_position - global_position
	dir = dir.normalized()
	position += dir * Speed * delta


func _on_area_entered(area):
	var unit_hit = area.get_parent()
	if unit_hit == Target:
		unit_hit.damage(Damage)
		queue_free()
