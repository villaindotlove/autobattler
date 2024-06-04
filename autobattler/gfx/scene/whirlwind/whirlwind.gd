@tool extends Node3D

@export_color_no_alpha var Colour
@export var PrimaryPanSpeed: Vector2
@export var SecondaryPanSpeed: Vector2
@onready var material = $MeshInstance3D.get_surface_override_material(0)
 
func _process(_delta):
	if Engine.is_editor_hint():
		material.set_shader_parameter("PillarColour", Colour)
		material.set_shader_parameter("PrimaryPanning", PrimaryPanSpeed)
		material.set_shader_parameter("SecondaryPanning", SecondaryPanSpeed)
