extends Node

var UnitData = {}

func _ready():
	var dto = CsvDto.new()
	dto = CsvParse.csv_parse(dto, "res://data/unit_data/unit_data.csv")
	for obj in dto.ParsedObjects:
		UnitData[obj["Name"]] = obj
	var dog = 2
