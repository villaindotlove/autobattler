class_name SpellBody extends Node3D

signal on_spell_hit

@onready var Hitbox: Area3D = %Hitbox

func _ready():
	Hitbox.area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	on_spell_hit.emit(area)
