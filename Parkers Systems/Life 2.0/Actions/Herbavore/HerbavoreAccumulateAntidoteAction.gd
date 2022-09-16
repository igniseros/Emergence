extends Action
class_name HerbavoreAccumulateAntidoteAction

var mineral_cost = 0
var energy_cost = MutableFloatAttribute.new("Energy cost", 1, 0)

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	dot.minerals.set_value(dot.minerals.get_value() - mineral_cost)
	dot.use_energy(energy_cost.get_value())
	
	dot.antidote.affect_value(energy_cost.get_value())
	
func get_color():
	return Color(.5,1,1)

func _to_string():
	return "[Accumulate Antidote Action]"
