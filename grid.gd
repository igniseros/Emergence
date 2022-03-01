extends Node

var grid = []
var time = 0

func get_at(pos : Vector2):
	if good_pos(pos):
		return grid[pos.x][pos.y]
	else:
		return -1

func set_at(pos : Vector2, dot : Dot):
	if good_pos(pos):	
		grid[pos.x][pos.y] = dot
	else:
		return -1

func good_pos(pos : Vector2):
	return pos.x < grid.size() and pos.y < grid[0].size() and pos.x>0 and pos.y>0
