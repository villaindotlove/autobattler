class_name Tile extends MeshInstance3D

var coord: Vector2i
var neighbours = []
var occupied = false
var _occupied_mat = preload("res://material/occupied.tres") 
var _unoccupied_mat = preload("res://material/unoccupied.tres")

func _process(_delta):
	if occupied:
		set_surface_override_material(0, _occupied_mat)
	else:
		set_surface_override_material(0, _unoccupied_mat)

func _to_string() -> String:
	return str(coord)

func is_occupied() -> bool:
	return occupied
