extends Action
class_name PlantShareEnergyAction

var mineral_cost = 0
var energy_cost = .01
var energy_shared_per_dot : MutableFloatAttribute = \
MutableFloatAttribute.new("Energy shared per dot", .2, 0, 1)

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	if dot.minerals.get_value() > mineral_cost and dot.energy.get_value() > energy_cost:
		dot.minerals.set_value(dot.minerals.get_value() - mineral_cost)
		dot.use_energy(energy_cost)
	else:
		return
	
	for spot in PDF.look_at_array(dot, PDF.box_around):
		if spot is LifePlusBaseDot and spot.name.get_value() == dot.name.get_value():
			var giver = spot if spot.energy.get_value() > dot.energy.get_value() else dot
			var reciever = spot if giver == dot else dot
			var gift = giver.energy.get_value() * energy_shared_per_dot.get_value()
			gift = clamp(gift,0,giver.energy.get_value() - reciever.energy.get_value())
			if gift < giver.energy.get_value():
				reciever.use_energy(-gift)
				giver.use_energy(gift)

func random_change(scale):
	energy_shared_per_dot.mutate(1,scale)

func get_color():
	return Color(1,1,1)

func _to_string():
	return "[Share Energy Action]"

func get_save_value():
	return .get_save_value() + "~" + str(energy_shared_per_dot.get_value())
	
func load_value(v : String):
	var action_data = v.split("~")
	energy_shared_per_dot.set_value(action_data[1])
