extends Node

var grid = []
var dot_register : Dictionary = {} #all dots
var tick_registrer : Dictionary = {} #dots that tick
var delete_list = [] #dots to delete soon
var time = 0
var size_x = 2024
var size_y = 2024
var grid_node : Node2D

var paused = true
var using_timer = false
var elapsed_since_last_tick = 0
var timer_per_tick = .25
var last_id = 0

var will_report_issues = true
var ticks_per_report = 100
var ticks_since_last_report = 0
var illegit_since_last_report = 0
var unregistered_since_last_report = 0
var bad_pos_insert_since_last_report = 0
var bad_pos_delete_since_last_report = 0

signal _on_tick

func _ready():
	flush_grid()
	set_process(true)

func _process(delta):
	if not paused:
		if not using_timer:
			tick()
		if using_timer:
			if elapsed_since_last_tick > timer_per_tick:
				tick()
				elapsed_since_last_tick = 0
			else:
				elapsed_since_last_tick += delta

func get_at(pos : Vector2):
	if good_pos(pos) and len(grid) > 0:
		var dot = grid[pos.x][pos.y]
		if is_legit_dot(dot):
			return dot
		elif dot is Dot:
			remove_dot(dot)
			return 0
	else:
		return -1

func set_at(pos : Vector2, dot : Dot):
	if good_pos(pos):
		grid[pos.x][pos.y] = dot
	else:
		return -1

func where_is(dot : Dot):
	for x in range(size_x):
		for y in range(size_y):
			var at_spot = get_at(Vector2(x,y))
			if at_spot is Dot:
				if dot == at_spot:
					return Vector2(x,y)
	return null

func good_pos(pos : Vector2):
	if pos.x < 0 or pos.x >= size_x:
		return false
	if pos.y < 0 or pos.y >= size_y:
		return false
	return true

func is_dot_actually_in_grid(dot):
	var at_pos = grid[dot.position.x][dot.position.y]
	if (not at_pos is int) and at_pos == dot:
		return true
	return false

func is_legit_dot(dot : Dot):
	if dot is Dot and dot._active and good_pos(dot.position) and is_dot_actually_in_grid(dot) and dot_register.has(dot.ID):
		return true
	else:
		if dot is Dot: Grid.remove_dot(dot)
		return false

#makes a new grid
func flush_grid():
	grid = []
	dot_register = {}
	tick_registrer = {}
	time = 0
	last_id = 0
	for x in range(size_x):
		Grid.grid.append(Array())
		for _y in range(size_y):
#			var dot = Dot.new()
			Grid.grid[x].append(0)

func insert_dot(dot : Dot):
	#set check for things
	if not good_pos(dot.position):
		bad_pos_insert_since_last_report+=1
		return
	
	if Grid.get_at(dot.position) is Dot:
		Grid.remove_dot(Grid.get_at(dot.position))
	
	#add dot to grid
	dot.ID = last_id
	dot._active = true
	dot_register[dot.ID] = dot
	Grid.grid[dot.position.x][dot.position.y] = dot
	last_id += 1
	
	if not dot._attributes_added: dot.add_attributes()
	
	#load dot to register
	if(dot.will_tick()):
		tick_registrer[dot.ID] = dot

func remove_dot(dot : Dot):
	if not good_pos(dot.position):
		bad_pos_delete_since_last_report += 1
		return
	
	if(dot.will_tick()):
		var does_dot_tick = tick_registrer.has(dot.ID)
		if does_dot_tick:
			tick_registrer.erase(dot.ID)
		
	var is_dot_registered = dot_register.has(dot.ID)
	if is_dot_registered:
		dot_register.erase(dot.ID)
	else:
		unregistered_since_last_report += 1
	
	if is_dot_actually_in_grid(dot):
		Grid.grid[dot.position.x][dot.position.y] = 0
	else:
		illegit_since_last_report += 1
	
	dot._active = false
	delete_list.append(dot)
	
#ticks the grid
func tick():
	for dot in delete_list:
		if is_instance_valid(dot):
			dot.free()
	delete_list = []
	
	time += 1
	for dot in tick_registrer.values():
		(dot as Dot).tick_wrap()
	emit_signal("_on_tick")
	
	if ticks_since_last_report >= ticks_per_report:
		report_issues()
	ticks_since_last_report += 1
	

func report_issues():
	ticks_since_last_report = 0
	
	if not will_report_issues or\
	illegit_since_last_report + unregistered_since_last_report + bad_pos_insert_since_last_report \
	+ bad_pos_delete_since_last_report == 0:
		return
	
	print("------REPORT at " + str(time))
	if illegit_since_last_report > 0: print("illegit: " + str(illegit_since_last_report))
	if unregistered_since_last_report > 0: print("unregistered: " + str(unregistered_since_last_report))
	if bad_pos_insert_since_last_report > 0: print("bad pos insert: " + str(bad_pos_insert_since_last_report))
	if bad_pos_delete_since_last_report > 0: print("bad pos delete: " + str(bad_pos_delete_since_last_report))
	
	illegit_since_last_report = 0
	unregistered_since_last_report = 0
	bad_pos_insert_since_last_report = 0
	bad_pos_delete_since_last_report = 0

func load_image(image):
	print("loading image")
	var bag_of_dots = Converter.do_the_thing(image.get_data()) #converter does the thing
	flush_grid()
	var _id = 0
	for dot in bag_of_dots: #empty bag of dots onto grid
		dot.ID = _id
		Grid.insert_dot(dot)
		_id += 1
	
	#call prefirsttick()
	for dot in Grid.dot_register:
		dot.pre_first_tick()

func set_gridnode(node):
	grid_node = node
