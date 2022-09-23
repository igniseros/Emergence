extends InputStyle
class_name PlantCategoriesInutStyle

static func input_count():
	return 42

static func gather_inputs(dot : LifePlusBaseDot):
	var arr = []
	
	var plants_seen = 0
	var dirt_seen = 0
	var life_seen = 0
	var other_seen = 0
	
	#section 1 = 8 * 4 = 32
	var spots_to_look_at = PDF.box_around
	for seen_dot in PDF.look_at_array(dot, spots_to_look_at):
		var slot = [0,0,0,0]
		if not seen_dot is Dot:
			pass
		else:
			if seen_dot.name.get_value() == dot.name.get_value():
				plants_seen += 1
				slot[0] = 1
			elif seen_dot is LifePlusBaseDot:
				life_seen += 1
				slot[1] = 1
			elif seen_dot is DirtDot:
				dirt_seen += 1
				slot[2] = 1
			else:
				other_seen += 1
				slot[3] =1
		
		arr.append_array(slot)
	
	
	#section 2 = 10
	arr.append(dirt_seen)
	arr.append(plants_seen)
	arr.append(life_seen)
	arr.append(other_seen)
	arr.append(dot.dirt_seen_recently.add(life_seen))
	arr.append(dot.plants_seen_recently.add(life_seen))
	arr.append(dot.life_seen_recently.add(life_seen))
	arr.append(log(dot.energy.get_value() + exp(1)) - 1)
	arr.append(log(dot.minerals.get_value() + exp(1)) - 1)
	arr.append(log(dot.poison.get_value() + exp(1)) - 1)
	
	return Vector.new(arr)
