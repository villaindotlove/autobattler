class_name Board extends Node3D

var TileScenes
var Camera
var Dimensions: Vector2i
var Size: Vector2
var Tiles = { }
@export var UnitLocations = { }

var _tile_prefab = preload("res://tile.tscn")

func _start_automatons():
	for unit in UnitLocations:
		unit.Clock.start()
		unit.MovementComponent.move_completed.connect(_move_unit)
		unit.MovementComponent.assign_closest_target(get_opposition_units(unit.IsEnemy))

func get_opposition_units(is_enemy):
	var opposition_units = []
	for unit in UnitLocations.keys():
		if unit.IsEnemy != is_enemy:
			opposition_units.append(unit)
	return opposition_units

func _init(dimensions: Vector2i, size: Vector2):
	Dimensions = dimensions
	Size = size
	name = "Board"
	BoardReference.Instance = self
	TileScenes = Node3D.new()
	TileScenes.name = "TILES"
	add_child(TileScenes)
	
	var space_increment = Vector2(Size.x / Dimensions.x, Size.y / Dimensions.y)
	
	for x in Dimensions.x:
		for y in Dimensions.y:
			var t = _tile_prefab.instantiate()
			TileScenes.add_child(t)
			t.position = Vector3(space_increment.x * x, 0.0, space_increment.y * y)
			Tiles[Vector2i(x,y)] = t
			t.coord = Vector2i(x,y)
			t.name = str(Vector2i(x,y))
			t.get_node("Platform").received_object.connect(_move_unit)
	
	_set_tile_neighbours()
	
	Camera = Camera3D.new()
	add_child(Camera)
	Camera.position = Vector3(Size.x/2, 10.0, Size.y)
	Camera.rotation = Vector3(-PI/3, 0.0, 0.0)

func _set_tile_neighbours():
	for tile in Tiles.values():
		var neighbours = []
		if tile.coord.x != 0:
			neighbours.append(Tiles[Vector2i(tile.coord.x - 1, tile.coord.y)])
		if tile.coord.x != Dimensions.x - 1:
			neighbours.append(Tiles[Vector2i(tile.coord.x + 1, tile.coord.y)])
		if tile.coord.y != 0:
			neighbours.append(Tiles[Vector2i(tile.coord.x, tile.coord.y - 1)])
		if tile.coord.y != Dimensions.y - 1:
			neighbours.append(Tiles[Vector2i(tile.coord.x, tile.coord.y + 1)])
		
		tile.neighbours = neighbours

func _move_unit(unit, tile):
	if UnitLocations.has(unit):
		UnitLocations[unit].occupied = false
	UnitLocations[unit] = tile
	tile.occupied = true
	unit.MovementComponent.CurrentTile = tile
