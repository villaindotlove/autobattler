extends Timer

signal clock_timeout

var clock_speed: float
var clock_timer: float
@onready var ParentUnit = get_parent()

func add_time(interval: float) -> void:
	clock_timer += interval

func update_clock_speed(new_clock_speed: float) -> void:
	var elapsed = clock_speed - clock_timer
	clock_speed = new_clock_speed
	clock_timer = clock_speed - elapsed

func _process(delta) -> void:
	clock_timer -= delta
	if clock_timer <= 0.0:
		clock_timeout.emit()
		clock_timer = clock_speed

func _ready() -> void:
	_load_clock.call_deferred()

func _load_clock() -> void:
	wait_time = ParentUnit.Attributes.Speed
	clock_timer = clock_speed
