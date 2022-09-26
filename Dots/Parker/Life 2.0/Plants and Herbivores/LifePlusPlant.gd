extends LifePlusBrainDot
class_name LifePlusPlantDot

const MAX_ENERGY = 500
const MAX_MINERALS = 1000
var minerals : FloatAttribute = FloatAttribute.new("Minerals", 0, 0, MAX_MINERALS)
var poison : FloatAttribute = FloatAttribute.new("Poison", 0, 0, MAX_ENERGY)

var life_seen_recently = Pile.new(.1)
var dirt_seen_recently = Pile.new(.1)
var plants_seen_recently = Pile.new(.1)

func _init(_is_child = false, _parent = null).(_is_child, _parent):
	#basics
	name.set_value("Life Plus Plant")
	#set colors
	color_one.set_value(Color(0, 1,0))
	color_two.set_value(Color(0,.5,0))
	color_three.set_value(Color(0,.5,0))
	
	energy = FloatAttribute.new("Energy", 30, 0, MAX_ENERGY)
	#--variables--
	basel_metabolic_rate.set_value(0.1)
	reproduction_threshold = MutableFloatAttribute.new("Reproducton threshold", 60, 20, MAX_ENERGY - .1)
	reproduction_gift.set_value(.75)
	death_threshold = MutableFloatAttribute.new("Death Threshold (energy)", 0, 0, 0)

	#--brain and habits--
	input_style = PlantCategoriesInutStyle
	input_count = input_style.input_count()
	output_count = 6
	brain = LifeBrainAttribute.new("Brain", null, 1)

	allowed_actions = [DieAction, RandomWalkAction, SpecificWalkAction, PlantGainMoreEnergyAction, PlantShareEnergyAction, 
	PlantShareMineralsAction, PlantAccumulatePoisonAction, CreateWallAction, RemoveWallAction, PushAction] #TODO
	default_habit = [PlantGainMoreEnergyAction.new(), PlantShareEnergyAction.new(), PlantShareMineralsAction.new()]
	habits = HabbitAttribute.new("Habits", allowed_actions)
	max_actions_per_habbit.set_value(15)
	calibrate()

func calibrate():
	.calibrate()
	
	if not is_child:
		build_habits()
		brain.set_value(LifeBrain.new(input_count, output_count))

func add_attributes():
	.add_attributes()
	attributes.append_array([minerals,poison])

func life_tick():
	.life_tick()
	var energv_vs_poison = energy.get_value() - poison.get_value()
	energv_vs_poison = (log(energv_vs_poison + exp(1)) - 1) / 5
	var r = clamp(-energv_vs_poison, 0, 1)
	var g = clamp(energv_vs_poison, 0, 1)
	var b = clamp(-energv_vs_poison, 0, 1)
	var energy_color = Color(r,g,b)
	
	var ratio = energy.get_value() / (minerals.get_value() if minerals.get_value() else .000001)
	if ratio == 0: ratio = .0001
	var mineral_color_scale = log(minerals.get_value() + exp(1) - 1) / 10  
	var mineral_color = energy_color.linear_interpolate(Color(1,1,1) * mineral_color_scale, clamp(1.0/ratio,0,.7))
	var reproduce_ratio = clamp( (energy.get_value() / reproduction_threshold.get_value()) ,0, 1.0)
	mineral_color *= reproduce_ratio
	mineral_color.a = 1
	color_two.set_value(mineral_color)
	color_one.set_value(mineral_color)
	
	var attempts = 3
	for i in range(attempts):
		var dot = PDF.look_at(self, PDF.box_around[floor(randf() *  7.9999)])
		if dot is DirtDot:
			dot.transfer_minerals(self)
		
func assemble_child(child_energy):
	var child = .assemble_child(child_energy)
	child.minerals.set_value(0)
	child.poison.set_value(0)
	return child

func gain_minerals(value):
	minerals.set_value(minerals.get_value() + value)

func die(makefood = false):
	.die(makefood)
