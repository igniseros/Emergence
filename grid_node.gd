extends Node2D

#starting variables
export var grid_path = "res://basic.grid"
export var image : Texture
export var use_img = false
export var size_x = 256
export var size_y = 256
export var draw = true
export var cheap_draw = false
export var draw_per = 1
var dot_register = []

func _ready():
	set_up()

func set_up():
	flush_grid()
	#load grid if using .grid
	if(not use_img):load_grid()
	else: #load from image if doing that
		print("loading image")
		var bag_of_dots = Converter.do_the_thing(image.get_data()) #converter does the thing
		for dot in bag_of_dots: #empty bag of dots onto grid
			insert_dot(dot)

#makes a new grid
func flush_grid():
	Grid.grid = []
	Grid.time = 0
	for x in range(size_x):
		Grid.grid.append([])
		for _y in range(size_y):
#			var dot = Dot.new()
			Grid.grid[x].append(0)

#loads a grid from file
func load_grid():
	var f = File.new()
	f.open(grid_path, File.READ)
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		line = str(line).split(',')
		#figure which dot
		var dot : Dot = (TheGreatConnection.XD[line[0]].new() as Dot)
		#set dot position
		dot.position = Vector2(int(line[1]),int(line[2]))
		dot.name = line[0]
		#add dot to grid
		insert_dot(dot)
	f.close()
	

func insert_dot(dot : Dot):
	#add dot to grid
	Grid.grid[dot.position.x][dot.position.y] = dot
	#load dot to register
	dot_register.append(dot)
	#update dot's grid
	dot.grid_node = self

func remove_dot(dot : Dot):
	#if the dot is there, remove it
	if(dot_register.has(dot)): 
		dot_register.remove(dot_register.find(dot))
		var air =  Dot.new()
		air.position = dot.position
		Grid.grid[dot.position.x][dot.position.y] = air
		dot.grid_node = null
	
	
#draws the grid
func _draw():
	if not draw:
		return
	
	for line in Grid.grid:
		for dot in line:
			if(dot is Dot):
				dot = dot as Dot
				if not dot.name == "Dot":
					var square1 = Rect2(Vector2(dot.position.x,dot.position.y),Vector2(1,1))
					draw_rect(square1,dot.color_one)
					if(not cheap_draw):
						var square2 = Rect2(Vector2(dot.position.x + .16,dot.position.y + .16),Vector2(.66,.66))
						var square3 = Rect2(Vector2(dot.position.x + .45,dot.position.y + .45),Vector2(.1,.1))
						draw_rect(square2,dot.color_two)
						draw_rect(square3,dot.color_three)

#ticks the grid
func tick():
	Grid.time += 1
	for dot in dot_register:
		if(dot is Dot):
			(dot as Dot).tick()
	if Grid.time % draw_per == 0: update()
