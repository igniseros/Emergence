extends Panel

var attribute : LifeBrainAttribute
const Scale = 10

func set_attribute(a : LifeBrainAttribute):
	attribute = a
	var size = attribute.get_value().weight_matrix.size()
	rect_min_size = Vector2(Scale * (size[0]), Scale * (size[1] + 3))

func _draw():
	var wm = attribute.get_value().weight_matrix
	var bv = attribute.get_value().bias_vector
	
	
	for x in range(wm.size()[0]):
		for y in range(wm.size()[1]):
			var val = (wm.get_elem(x,y) + 1) / 2
			var color = Color(val,0,1-val)
			draw_square(Vector2(x,y), Scale, color)
	
	for x in range(bv.size()):
		var val = (bv.get_elem(x) + 1) / 2
		var color = Color(val,0,1-val)
		draw_square(Vector2(x,wm.size()[1] + 2), Scale, color)

func draw_square(position : Vector2, scale, color : Color):
	draw_rect(Rect2(position * scale, Vector2(scale,scale)), color)
