extends Action
class_name HerbavoreEatPlantAction

var mineral_cost = 0
var energy_cost = .2

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	dot.minerals.set_value(dot.minerals.get_value() - mineral_cost)
	dot.use_energy(energy_cost)
	
	if dot.alive.get_value():
		for seen_dot in PDF.look_at_array(dot, PDF.box_around):
			if seen_dot is LifePlusPlantDot:
				dot.energy.affect_value(seen_dot.energy.get_value() - 
					(seen_dot.poison.get_value() - dot.antidote.get_value()))
				dot.minerals.affect_value(seen_dot.minerals.get_value())
				seen_dot.die(false)
	
func get_color():
	return Color(.5,1,1)

func _to_string():
	return "[Eat Plant Action]"
