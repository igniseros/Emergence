extends Sprite

export var grid_node : NodePath

func _ready():
	set_process(true)

func _process(delta):
	if get_node(grid_node).draw:
		texture = null
