@tool 
class_name UnitInfoField
extends HBoxContainer

@onready var _field_label = %FieldName
@onready var _value_label = %Value

@export var FieldName: String : set = _set_field
@export var Value: String : set = _set_value

func _set_field(value):
	if _field_label:
		_field_label.text = value
	FieldName = value

func _set_value(value):
	if _value_label:
		_value_label.text = value
	Value = value

func _ready():
	_field_label.text = FieldName
	_value_label.text = Value
