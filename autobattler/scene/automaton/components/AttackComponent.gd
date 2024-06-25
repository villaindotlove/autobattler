extends Node

var unit: Automaton
var target_component: TargetingComponent

func _begin_attack_animation(target):
	unit.look_at(target.position)
	Model.play_attack_animation(Attributes.get_speed())

func _create_attack_hitbox():
	var p = AttackHitbox.instantiate()
	p.hit.connect(_on_attack_hit)
	get_tree().root.add_child(p)
	p.global_position = global_position
	p.begin_motion(TargetComponent.Target)
