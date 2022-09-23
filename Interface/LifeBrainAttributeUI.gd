extends Panel

var attribute : LifeBrainAttribute
const Scale = 10
const Offset = Vector2(0,0)

var bv_n : Vector
var wm_n : Matrix

func set_attribute(a : LifeBrainAttribute):
	Grid.connect("_on_tick", self, "_on_tick")
	attribute = a
	var size = attribute.get_value().weight_matrix.size()
	rect_min_size = Vector2(Scale * (size[0]), clamp(Scale * (size[1] + 6),240,2<<60)) + Offset
	bv_n = a.get_value().bias_vector.normalize()
	wm_n = a.get_value().weight_matrix.copy()
	
	for i in range(wm_n.size()[0]):
		wm_n.rows[i] = wm_n.rows[i].normalize()

func _draw():
	Utils.draw_vector_vertically(self, attribute.get_value().last_input, Scale, Offset)
	Utils.draw_matrix(self, wm_n, Scale, Offset + Vector2(2 * Scale,0))
	Utils.draw_vector(self, bv_n, Scale, Offset + Vector2(2* Scale, (Scale * wm_n.size()[1] )+ (2*Scale)))
	Utils.draw_vector(self, attribute.get_value().last_output, Scale, Offset + Vector2(2* Scale, (Scale * wm_n.size()[1] )+ (4*Scale)))
	var choice_arr = []
	for i in range(bv_n.size()):
		choice_arr.append(0)
	choice_arr[attribute.get_value().last_answer] = 1
	var choice_vec = Vector.new(choice_arr)
	Utils.draw_vector(self, choice_vec, Scale, Offset + Vector2(2* Scale, (Scale * wm_n.size()[1] )+ (4*Scale)))
	
#	for x in range(wm_n.size()[0]):
#		for y in range(wm_n.size()[1]):
#			var color = Utils.calc_color(wm_n.get_elem(x,y))
#			Utils.draw_square(self, Vector2(x,y), color, Scale, Offset)
#
#	for x in range(bv_n.size()):
#		var color = Utils.calc_color(bv_n.get_elem(x))
#		Utils.draw_square(self,Vector2(x,wm_n.size()[1] + 2), color, Scale, Offset)


func _on_tick():
	update()
