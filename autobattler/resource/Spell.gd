class_name Spell extends Resource

@export var Name: String
@export var Cost: int
@export var Damage: int
@export var Healing: int
@export var MissileSpeed: float
@export var Pierce: int

@export var Buffs = []
@export var Debuffs = []

@export var OnCastProc: Spell
@export var OnHitProc: Spell

@export var Duration: float
@export var DurationProc: Spell

@export var TargetingFunction: SpellTargeting.Type
@export var MovementFunction: SpellMovement.Type

@export var Particle: PackedScene

@export var Icon: Texture2D
@export_multiline var Description: String
