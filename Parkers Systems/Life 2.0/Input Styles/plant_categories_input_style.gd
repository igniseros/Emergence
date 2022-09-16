extends InputStyle
class_name PlantCategoriesInutStyle

static func input_count():
	return 37

static func gather_inputs(dot : LifePlusBaseDot):
	var arr = []
	
	var plants_seen = 0
	var poison_plants_seen = 0
	var dirt_seen = 0
	var walls_seen = 0
	var life_seen = 0
	var other_seen = 0
	
	var spots_to_look_at = [Vector2(0,1),Vector2(0,-1), Vector2(1,0), Vector2(-1,0)]
	for seen_dot in PDF.look_at_array(dot, spots_to_look_at):
		var slot = [0,0,0,0,0,0]
		if not seen_dot is Dot:
			pass
		else:
			if seen_dot.name.get_value() == dot.name.get_value():
				if seen_dot.poison > seen_dot.energy:
					plants_seen += 1
					slot[0] = 1
				else:
					poison_plants_seen += 1
					slot[1] = 1
			elif seen_dot is LifePlusBaseDot:
				life_seen += 1
				slot[2] = 1
			elif seen_dot is DirtDot:
				dirt_seen += 1
				slot[3] = 1
			elif seen_dot is PushableWallDot:
				walls_seen += 1
				slot[4] = 1
			else:
				other_seen += 1
				slot[5] =1
		
		arr.append_array(slot)
	
	arr.append(dirt_seen)
	arr.append(plants_seen)
	arr.append(poison_plants_seen)
	arr.append(walls_seen)
	arr.append(life_seen)
	arr.append(other_seen)
	arr.append(dot.dirt_seen_recently.add(life_seen))
	arr.append(dot.plants_seen_recently.add(life_seen))
	arr.append(dot.poison_plants_seen_recently.add(life_seen))
	arr.append(dot.life_seen_recently.add(life_seen))
	arr.append(log(dot.energy.get_value() + exp(1)) - 1)
	arr.append(log(dot.minerals.get_value() + exp(1)) - 1)
	arr.append(log(dot.poison.get_value() + exp(1)) - 1)
	
	return Vector.new(arr)
