extends Node

var grid = []
var time = 0

func get_at(pos : Vector2):
	return grid[pos.x][pos.y]

func set_at(pos : Vector2, dot : Dot):
	grid[pos.x][pos.y] = dot
