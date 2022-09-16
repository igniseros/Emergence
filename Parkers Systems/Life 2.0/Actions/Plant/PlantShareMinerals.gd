extends Action
class_name PlantShareMineralsAction

var mineral_cost = .1
var energy_cost = .1
var minerals_shared_per_dot : MutableFloatAttribute = \
MutableFloatAttribute.new("Energy shared per dot", .5, 0, 1)

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	dot.minerals.set_value(dot.minerals.get_value() - mineral_cost)
	dot.use_energy(energy_cost)
	
	for spot in PDF.look_at_array(dot, PDF.box_around):
		if spot is LifePlusBaseDot and spot.name.get_value() == dot.name.get_value():
			var gift = dot.minerals.get_value() * minerals_shared_per_dot.get_value()
			if dot.minerals.get_value() > gift:
				dot.minerals.affect_value(-gift)
				spot.minerals.affect_value(gift)
				

func random_change(scale):
	minerals_shared_per_dot.mutate(1,scale)

func get_color():
	return Color(1,1,1)

func _to_string():
	return "[Share Energy Action]"
