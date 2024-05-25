extends Node3D

@onready var start_button = $Button
var board

func _ready():
	board = Board.new(Vector2i(12,12), Vector2(20,20))
	add_child(board)
	start_button.pressed.connect(board._start_automatons)
