class_name InventoryUnit extends Control

@export var Unit: PackedScene
@export var Icon: Texture2D
@onready var _icon_rect = $TextureRect

func _ready():
	_icon_rect.texture = Icon
