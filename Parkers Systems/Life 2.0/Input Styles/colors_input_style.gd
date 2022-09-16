extends InputStyle
class_name ColorsInputStyle

static func input_count():
	return 3*3*8

static func gather_inputs(dot : LifePlusBaseDot):
	var inputs = []
	
	for seen_dot in PDF.look_at_array(dot, PDF.box_around):
		if seen_dot is PhysDot:
			var c1 = seen_dot.color_one.get_value()
			var c2 = seen_dot.color_two.get_value()
			var c3 = seen_dot.color_three.get_value()
			inputs.append(c1.r)
			inputs.append(c1.g)
			inputs.append(c1.b)
			inputs.append(c2.r)
			inputs.append(c2.g)
			inputs.append(c2.b)
			inputs.append(c3.r)
			inputs.append(c3.g)
			inputs.append(c3.b)
		else:
			inputs.append_array([0,0,0,0,0,0,0,0,0])
	
	return Vector.new(inputs)
