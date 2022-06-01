extends Node

var grid = []
var dot_register = [] #all dots
var tick_registrer = [] #dots that tick
var time = 0
var size_x = 1024
var size_y = 1024

signal _on_tick

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
	return true
#	return pos.x < grid.size() and pos.y < grid[0].size() and pos.x>0 and pos.y>0


#makes a new grid
func flush_grid():
	grid = []
	dot_register = []
	tick_registrer = []
	time = 0
	for x in range(size_x):
		Grid.grid.append([])
		for _y in range(size_y):
#			var dot = Dot.new()
			Grid.grid[x].append(null)
			

func insert_dot(dot : Dot):
	#add dot to grid
	Grid.grid[dot.position.x][dot.position.y] = dot
	#load dot to register
	dot_register.append(dot)
	if(dot.will_tick()):
		tick_registrer.append(dot)
	#update dot's grid

func remove_dot(dot : Dot):
	#if the dot is there, remove it
	if(dot_register.has(dot)): 
		if(dot.will_tick()):
			tick_registrer.remove(tick_registrer.find(dot))
		dot_register.remove(dot_register.find(dot))
		Grid.grid[dot.position.x][dot.position.y] = 0
		dot.grid_node = null

#ticks the grid
func tick():
	time += 1
	for dot in tick_registrer:
		(dot as Dot).tick_wrap()
	emit_signal("_on_tick")
