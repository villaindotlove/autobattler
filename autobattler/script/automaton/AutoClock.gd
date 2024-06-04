extends Timer

@onready var ParentUnit = get_parent()

func _ready():
	_load_clock.call_deferred()

func _load_clock():
	wait_time = ParentUnit.Attributes.Speed
