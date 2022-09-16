extends InputStyle
class_name HerbavoreCategoriesInutStyle

static func input_count():
	return 48

static func gather_inputs(dot : LifePlusBaseDot):
	var arr = []
	
	var plants_seen = 0
	var poison_plants_seen = 0
	var walls_seen = 0
	var life_seen = 0
	var other_seen = 0
	
	var spots_to_look_at = PDF.box_around
	for seen_dot in PDF.look_at_array(dot, spots_to_look_at):
		var slot = [0,0,0,0,0]
		if not seen_dot is Dot:
			pass
		else:
			if seen_dot is LifePlusPlantDot:
				if seen_dot.poison > seen_dot.energy:
					plants_seen += 1
					slot[0] = 1
				else:
					poison_plants_seen += 1
					slot[1] = 1
			elif seen_dot is LifePlusBaseDot:
				life_seen += 1
				slot[2] = 1
			elif seen_dot is PushableWallDot:
				walls_seen += 1
				slot[3] = 1
			else:
				other_seen += 1
				slot[4] =1
		
		arr.append_array(slot)
	
	arr.append(plants_seen)
	arr.append(poison_plants_seen)
	arr.append(walls_seen)
	arr.append(life_seen)
	arr.append(other_seen)
	arr.append(log(dot.energy.get_value() + exp(1)) - 1)
	arr.append(log(dot.minerals.get_value() + exp(1)) - 1)
	arr.append(log(dot.antidote.get_value() + exp(1)) - 1)
	
	return Vector.new(arr)
