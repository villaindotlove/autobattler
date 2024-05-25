extends Timer

@onready var ParentUnit = get_parent()

func _ready():
	wait_time = ParentUnit.Speed
