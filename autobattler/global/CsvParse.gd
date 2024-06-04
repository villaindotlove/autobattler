extends Node

func csv_parse(dto: Dto, path: String) -> Dto:
	var file = FileAccess.open(path, FileAccess.READ)
	var headers = file.get_csv_line()
	while not file.eof_reached():
		dto.line_to_object(headers, file.get_csv_line())
	file.close()
	return dto
