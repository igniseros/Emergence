extends Action
class_name PlantGainMoreEnergyAction

var mineral_cost = 1
var energy_cost = 1
var energy_gain_per_open_square = 10
var starting_energy_gain = -30

var scale = 1

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	if dot.minerals.get_value() > mineral_cost * scale:
		dot.minerals.set_value(dot.minerals.get_value() - mineral_cost * scale)
		dot.use_energy(energy_cost * scale)
		
		var dirt_found = 0
		var energy_gain = starting_energy_gain
		for spot in PDF.look_at_array(dot, PDF.box_around):
			if (not spot is Dot) or spot.isEmpty():
				energy_gain += energy_gain_per_open_square
			if spot is DirtDot:
				dirt_found += 1
		
		if dirt_found > 0: dot.use_energy(-6 + dirt_found)
		else : dot.use_energy(-energy_gain * scale)

func random_change(scale : float):
	scale += rand_range(-scale, scale)
	scale = clamp(scale, 0, 1000)

func get_color():
	return Color(.5,1,1)

func _to_string():
	return "[Gain More Energy Action]"

