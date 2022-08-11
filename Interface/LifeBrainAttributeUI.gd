extends Panel

var attribute : LifeBrainAttribute
const Scale = 10

var bv_n : Vector
var wm_n : Matrix

func set_attribute(a : LifeBrainAttribute):
	attribute = a
	var size = attribute.get_value().weight_matrix.size()
	rect_min_size = Vector2(Scale * (size[0]), Scale * (size[1] + 3))
	bv_n = a.get_value().bias_vector.normalize()
	wm_n = a.get_value().weight_matrix.copy()
	
	for i in range(wm_n.size()[0]):
		wm_n.rows[i] = wm_n.rows[i].normalize()

func _draw():
	
	
	for x in range(wm_n.size()[0]):
		for y in range(wm_n.size()[1]):
			var val = (wm_n.get_elem(x,y) + 1) / 2
			var color = Color(val,0,1-val)
			draw_square(Vector2(x,y), Scale, color)
	
	for x in range(bv_n.size()):
		var val = (bv_n.get_elem(x) + 1) / 2
		var color = Color(val,0,1-val)
		draw_square(Vector2(x,wm_n.size()[1] + 2), Scale, color)

func draw_square(position : Vector2, scale, color : Color):
	draw_rect(Rect2(position * scale, Vector2(scale,scale)), color)
