class_name SpellFactory extends Node

func create_spell_instance(spell: Spell, is_enemy: bool) -> SpellInstance:
	var instance = SpellInstance.new()
	instance.Damage = spell.Damage
	instance.Healing = spell.Healing
	instance.MissileSpeed = spell.MissileSpeed
	instance.Pierce = spell.Pierce
	instance.IsEnemy = is_enemy
	
	var particle = spell.Particle.instantiate()
	instance.add_child(particle)
	particle.on_spell_hit.connect(instance.on_collision_enter)
	
	instance.MovementFunction = SpellMovement.Function[spell.MovementFunction]
	instance.TargetingFunction = SpellTargeting.Function[spell.TargetingFunction]
	
	for buff in spell.Buffs:
		_add_buff(buff)
	
	for debuff in spell.Debuffs:
		_add_debuff(debuff)
	
	if spell.DurationProc:
		assert(spell.Duration, "Cannot have duration proc without a duration")
		_add_duration_timer(instance, spell.Duration)
	
	return instance

func _add_buff(buff) -> void:
	pass

func _add_debuff(debuff) -> void:
	pass

func _add_duration_timer(instance: SpellInstance, duration: float) -> void:
	var duration_timer = Timer.new()
	duration_timer.wait_time = duration
	add_child(duration_timer)
	duration_timer.timeout.connect(instance._on_duration_timeout)
	duration_timer.start()
