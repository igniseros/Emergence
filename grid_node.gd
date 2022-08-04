extends Node2D

#starting variables
export var image : Texture
export var draw = true
export var cheap_draw = false
export var draw_per = 1
var starred_dots = []

func _ready():
	Grid.connect("_on_tick",self,"_on_tick")
	randomize()
	Grid.load_image(image)
	
	
#draws the grid
func _draw():
	if not draw:
		return
	
	for dot in Grid.dot_register:
		if not dot.name == "Dot":
			var square1 = Rect2(dot.position,Vector2(1,1))
			draw_rect(square1,dot.color_one)
			if(not cheap_draw):
				var square2 = Rect2(Vector2(dot.position.x + .16,dot.position.y + .16),Vector2(.66,.66))
				var square3 = Rect2(Vector2(dot.position.x + .45,dot.position.y + .45),Vector2(.1,.1))
				draw_rect(square2,dot.color_two)
				draw_rect(square3,dot.color_three)

func _on_tick():
	update()

func _input(event):
	if event is InputEventMouseButton and event.is_action_released("left_mouse"):
		var mx = get_local_mouse_position().x
		var my = get_local_mouse_position().y
		mx = floor(mx )
		my = floor(my)
		
		var node = Grid.get_at(Vector2(mx,my))
		if node is Dot : node._on_click()
