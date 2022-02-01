extends Sprite

export var grid_node : NodePath

func _ready():
	set_process(true)

func _process(delta):
	if get_node(grid_node).draw:
		texture = null
		set_process(false)

func _input(event):
	if event is InputEventMouseButton:
		var mx = get_local_mouse_position().x
		var my = get_local_mouse_position().y
		mx = floor(mx )
		my = floor(my)
		print(Vector2(mx,my))
		
		var node = Grid.get_at(Vector2(mx,my))
		if node is Dot : 
			print(node.name)
			$Stats.set_position(node.position + Vector2(0,-1))
			$Stats.text = node.name
			if(node is EvolvingLifeDot):
				addEvolvingLifeInfo(node)
			if(node is FoodDot):
				addFoodInfo(node)

func addEvolvingLifeInfo(node : EvolvingLifeDot):
	node = node as EvolvingLifeDot
	$Stats.set_position(node.position + Vector2(0,-3 - node.behavior.steps.size()))	
	$Stats.text += ", energy: " + str(node.energy) + "\n Generation: " + str(node.generation)  + " Age: " + str(node.time) + "\n Mutations: " + str(node.mutations)
	for i in range(node.behavior.steps.size()):
		var step = node.behavior.steps[i] as Step
		$Stats.text += "\n " + str(node.behavior.steps[i].name)
		for p in step.get_parameters():
			$Stats.text += " [" + str(p) + "] "

func addFoodInfo(node: FoodDot):
	$Stats.text += ": " + str(node.nutrition)
