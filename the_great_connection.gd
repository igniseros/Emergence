extends Node2D

var XD = {"dot" : Dot, "wall" : WallDot, "food" : FoodDot, "crawl" : CrawlDot}
var COLOR : Dictionary = {Color("#757574") : WallDot, Color("#ffff00") : FoodDot, Color("#ff00ff") : CrawlDot, Color("#f087f3") : CrawlFriendDot,
Color("#ffb41e"): GeneratorFood2Dot, Color("ff0080") : KillerCrawlDot, Color("ff6c80"): KillerCrawlFriendDot,
Color("#fffffe") : ColorDot, Color("#000000") : EvolvingLifeDot, Color("#111111") : PushableWallDot, Color("#AA00FF") : PushableCrawlDot,
LifePlusBasicDot.new().color_one.get_value() : LifePlusBasicDot,
LifePlusBrainDot.new().color_one.get_value() : LifePlusBrainDot,
DirtDot.new().color_one.get_value() : DirtDot, 
LifePlusPlantDot.new().color_one.get_value() : LifePlusPlantDot,
LifePlusHerbavoreDot.new().color_one.get_value() : LifePlusHerbavoreDot}

var grid_has_path : bool = false

var output = []

func add_color_connection(color,dot):
	COLOR[color] = dot

func store_data(data):
	output.append(data)

func save_data(file_path : String):
	var file = File.new()
	file.open(file_path, File.WRITE)
	for o in output:
		file.store_line(str(o))
	
	file.close()

func save_sim(file_path : String):
	if file_path.split(".")[-1] != "grid":
		file_path += ".grid"
	print("saving grid to: " + file_path)
	var file = File.new()
	file.open_compressed(file_path, File.WRITE, File.COMPRESSION_ZSTD)
	file.store_var("START OF GRID")
	file.store_var(Grid.time)
	file.store_var(Grid.size_x)
	file.store_var(Grid.size_y)
	file.store_var("START OF DOTS")
	for dot in Grid.dot_register.values():
		dot = dot as Dot
		file.store_var(dot.save_dot())
	
	file.store_var("END OF GRID")
	
	file.close()

func load_sim(file_path : String):
	print("loading grid from: " + file_path)
	var file = File.new()
	file.open_compressed(file_path, File.READ, File.COMPRESSION_ZSTD)
	print(file.get_var())
	Grid.flush_grid()
	Grid.time = file.get_var()
	Grid.size_x = file.get_var()
	Grid.size_y = file.get_var()
	print(str(Grid.size_x) + ", " + str(Grid.size_y))
	var dot = file.get_var()
	print(dot)
	while str(dot) != "END OF GRID":
		dot = file.get_var()
		if dot is Array: Grid.insert_dot(Dot.create_and_load(dot))
	file.close()
