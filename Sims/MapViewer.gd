extends Sprite

export var grid_node : NodePath

func _ready():
	set_process(true)

func _process(delta):
	if get_node(grid_node).draw:
		visible = false
		set_process(false)
