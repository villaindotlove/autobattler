class_name CsvDto extends Dto

var ParsedObjects = []

func line_to_object(headers: Array, line: Array) -> void:
	var obj = {}
	for i in headers.size():
		obj[headers[i]] = line[i]
	ParsedObjects.append(obj)
