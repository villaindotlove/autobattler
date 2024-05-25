extends Node

func a_star(start: Tile, target: Tile):
	var open_set = { start: null }
	var came_from = { }
	var g_scores = { start: 0 }
	var f_scores = { start: calculate_weight(start, target)}
	
	while not open_set.is_empty():
		var current = find_lowest_f_score(f_scores, open_set)
		if current == target:
			return reconstruct_path(came_from, current)
		open_set.erase(current)
		for neighbour in current.neighbours:
			if neighbour.is_occupied() and neighbour != target:
				continue
			var g_score = g_scores[current] + 1
			if neighbour in g_scores:
				if g_score < g_scores[neighbour]:
					came_from[neighbour] = current
					g_scores[neighbour] = g_score
					f_scores[neighbour] = g_score + calculate_weight(neighbour, target)
					if not neighbour.get_instance_id() in open_set:
						open_set[neighbour] = null
			else:
				came_from[neighbour] = current
				g_scores[neighbour] = g_score
				f_scores[neighbour] = g_score + calculate_weight(neighbour, target)
				if not neighbour.get_instance_id() in open_set:
					open_set[neighbour] = null
	return find_lowest_f_score(f_scores, came_from)

func find_lowest_f_score(f_scores: Dictionary, open_set: Dictionary):
	var lowest_value = INF
	var lowest_tile = null
	for key in f_scores.keys():
		if f_scores[key] < lowest_value and open_set.has(key):
			lowest_value = f_scores[key]
			lowest_tile = key
	return lowest_tile

func calculate_weight(current: Tile, target: Tile):
	return sqrt(pow(target.coord.x - current.coord.x, 2) + pow(target.coord.y - current.coord.y, 2))

func reconstruct_path(came_from: Dictionary, current: Tile):
	var total_path = [current]
	while came_from.keys().has(current):
		current = came_from[current]
		total_path.push_front(current)
	return total_path
