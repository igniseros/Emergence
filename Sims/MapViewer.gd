extends Sprite

export var grid_node : NodePath
export var stats : NodePath
export var grid_stats : NodePath
var node

func _ready():
	set_process(true)

func _process(delta):
	if get_node(grid_node).draw:
		texture = null
	update_label()
	get_node(grid_stats).text = str(Grid.time)

func _input(event):
	if event is InputEventMouseButton:
		var mx = get_local_mouse_position().x
		var my = get_local_mouse_position().y
		mx = floor(mx )
		my = floor(my)
		
		node = Grid.get_at(Vector2(mx,my))

func update_label():
	if node is Dot: 
			var Stats = get_node(stats) as Label
			Stats.text = node.name
			stats_new_line()
			if(node is EvolvingLifeDot):
				addEvolvingLifeInfo(node)
			if(node is FoodDot):
				addFoodInfo(node)

func add_stat(name, data):
	var Stats = get_node(stats) as Label	
	Stats.text += str(name) + ": " + str(data) + "  "

func stats_new_line():
	var Stats = get_node(stats) as Label	
	Stats.text += "\n"

func addEvolvingLifeInfo(node : EvolvingLifeDot):
	node = node as EvolvingLifeDot
	add_stat("Team", node.team)
	stats_new_line()
	add_stat("Generation", node.generation)
	add_stat("Mutations", node.mutations)
	add_stat("Energy", node.energy)
	stats_new_line()
	add_stat("[Reproduction] Cost:", node.reproduction_cost)
	add_stat("Chance: ", node.reproduction_chance)
	add_stat("Threshhold: ", node.reproduction_energy_thresh)
	stats_new_line()
	add_stat("[Mutation] Scale P", node.mutation_scale_p)
	add_stat("Scale S", node.mutation_scale_s)
	add_stat("Chance", node.mutation_chance)
	for i in range(node.behavior.steps.size()):
		var step = node.behavior.steps[i] as Step
		stats_new_line()
		var p_string = "[ "
		for p in step.get_parameters():
			p_string += str(p) + " "
		add_stat(step.get_name(), p_string + "] ")
		
func addFoodInfo(node: FoodDot):
	add_stat("Nutrition", node.nutrition)
