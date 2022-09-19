extends Action
class_name PlantAccumulatePoisonAction

var mineral_cost = 0
var energy_cost = MutableFloatAttribute.new("Energy cost", 1, 0)

var scale = 4

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	dot.minerals.set_value(dot.minerals.get_value() - mineral_cost)
	dot.use_energy(energy_cost.get_value())
	
	dot.poison.affect_value(energy_cost.get_value() * scale)
	
func get_color():
	return Color(.5,1,1)

func _to_string():
	return "[Accumulate Poison Action]"

func get_save_value():
	return .get_save_value() + "~" + str(energy_cost.get_value())
	
func load_value(v : String):
	var action_data = v.split("~")
	energy_cost.set_value(action_data[1])
