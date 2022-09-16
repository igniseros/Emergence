extends Panel

var attribute : LifeBrainAttribute
const Scale = 10
const Offset = Vector2(0,32)

var bv_n : Vector
var wm_n : Matrix

func set_attribute(a : LifeBrainAttribute):
	attribute = a
	var size = attribute.get_value().weight_matrix.size()
	rect_min_size = Vector2(Scale * (size[0]), clamp(Scale * (size[1] + 3),240,2<<60)) + Offset
	bv_n = a.get_value().bias_vector.normalize()
	wm_n = a.get_value().weight_matrix.copy()
	
	for i in range(wm_n.size()[0]):
		wm_n.rows[i] = wm_n.rows[i].normalize()

func _draw():
	Utils.draw_matrix(self, wm_n, Scale, Offset)
	Utils.draw_vector(self, bv_n, Scale, Offset + Vector2(0, (Scale * wm_n.size()[1] )+ (2*Scale)))
	
#	for x in range(wm_n.size()[0]):
#		for y in range(wm_n.size()[1]):
#			var color = Utils.calc_color(wm_n.get_elem(x,y))
#			Utils.draw_square(self, Vector2(x,y), color, Scale, Offset)
#
#	for x in range(bv_n.size()):
#		var color = Utils.calc_color(bv_n.get_elem(x))
#		Utils.draw_square(self,Vector2(x,wm_n.size()[1] + 2), color, Scale, Offset)
