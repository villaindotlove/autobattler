@tool extends Node3D

@export_color_no_alpha var RingColour
@export_color_no_alpha var PillarColour

@onready var _upper_ring = $UpperRing
@onready var _pillar = $Pillar
@onready var _lower_ring = $LowerRing

func _process(_delta):
	_upper_ring.get_surface_override_material(0).set_shader_parameter("RingColour", RingColour)
	_pillar.get_surface_override_material(0).set_shader_parameter("PillarColour", PillarColour)
	_lower_ring.get_surface_override_material(0).set_shader_parameter("RingColour", RingColour)
