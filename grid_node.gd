extends Node2D

#starting variables
export var draw = true
export var cheap_draw = false
export var draw_per = 1
var starred_dots = []

func _ready():
	Grid.connect("_on_tick",self,"_on_tick")
	Grid.set_gridnode(self)
	randomize()
	
#draws the grid
func _draw():
	
	if not draw:
		return
	
	draw_rect(Rect2(Vector2(0,0), Vector2(Grid.size_x, Grid.size_y)), Color(.3,.3,.3,1), false)
	
	for dot in Grid.dot_register.values():
		if not dot.name.get_value() == "Dot":
			var square1 = Rect2(dot.position,Vector2(1,1))
			draw_rect(square1,dot.color_one.get_value())
			if(not cheap_draw):
				var square2 = Rect2(Vector2(dot.position.x + .16,dot.position.y + .16),Vector2(.66,.66))
				var square3 = Rect2(Vector2(dot.position.x + .45,dot.position.y + .45),Vector2(.1,.1))
				draw_rect(square2,dot.color_two.get_value())
				draw_rect(square3,dot.color_three.get_value())
	
	
	UIMouse.draw_mouse(self)

func _on_tick():
	update()

func _input(event):
	if event is InputEventMouse:
		UIMouse.mouse_pos = UIMouse.quantize(get_local_mouse_position())
		update()
