extends Sprite

export var grid_node : NodePath
export var stats : NodePath
export var grid_stats : NodePath
var node

func _ready():
	set_process(true)

func add_one(x):
	return x+1

func _process(delta):
	if get_node(grid_node).draw:
		texture = null
	get_node(grid_stats).text = str(Grid.time)

func _input(event):
	if event is InputEventMouseButton:
		var mx = get_local_mouse_position().x
		var my = get_local_mouse_position().y
		mx = floor(mx )
		my = floor(my)
		
		node = Grid.get_at(Vector2(mx,my))
		if node is Dot : node._on_click()
