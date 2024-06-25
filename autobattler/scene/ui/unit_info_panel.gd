extends Control

@export var unit_resource: Unit
@onready var model_viewport: SubViewport = %ModelViewport
@onready var name_label: Label = %NameLabel
@onready var faction_field: UnitInfoField = %FactionField
@onready var job_field: UnitInfoField = %JobField
@onready var hp_label: UnitInfoField = %HpLabel
@onready var armour_label: UnitInfoField = %ArmourLabel
@onready var resistance_label: UnitInfoField = %ResistanceLabel
@onready var damage_label: UnitInfoField = %DamageLabel
@onready var speed_label: UnitInfoField = %SpeedLabel
@onready var ability_label: Label = %AbilityLabel
@onready var ability_icon: TextureRect = %AbilityIcon
@onready var ability_description: RichTextLabel = %AbilityDescription

func _ready():
	load_unit(unit_resource)

func load_unit(unit: Unit) -> void:
	name_label.text = unit.Name
	
	hp_label.Value = str(unit.Health)
	armour_label.Value = str(unit.BaseArmour)
	resistance_label.Value = str(unit.BaseResist)
	damage_label.Value = str(unit.BaseDamage)
	speed_label.Value = str(unit_resource.BaseSpeed)
	
	ability_label.text = str(unit.ActiveSpell.Name)
	ability_icon.texture = unit.ActiveSpell.Icon
