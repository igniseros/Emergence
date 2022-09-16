extends InputStyle
class_name CategoryInputStyle

static func input_count():
	return 41

static func gather_inputs(dot : LifePlusBaseDot):
	#inputs here are the colors of the dots around the current dot
	var inputs = []
	for seen_dot in PDF.look_at_array(dot, PDF.box_around):
		#categories : 0 - wall, 1 - food, 2 - family life, 3 - unkown life , 4 - unknown dot
		var category = [0,0,0,0,0]
		if seen_dot is PushableWallDot:
			category[0] = 1
		elif seen_dot is FoodDot:
			category[1] = log(abs(seen_dot.nutrition.get_value()) + 1)
		elif seen_dot is LifePlusBaseDot and (dot.parent == seen_dot or dot.children.has(seen_dot) or seen_dot.parent == dot.parent):
			category[2] = 1
		elif seen_dot is LifePlusBaseDot:
			category[3] = 1
		else:
			category[4] = 1
		inputs.append_array(category)
	
	#basically log( ((energy * e) / reproduction thresh) + 1)
	var last_input = log(((dot.energy.get_value()*exp(1)) / dot.reproduction_threshold.get_value()) + 1)
	if is_nan(last_input):
		last_input = 0
	inputs.append(last_input)
	return Vector.new(inputs)
