extends LifePlusBrainDot
class_name LifePlusHerbavoreDot

const MAX_ENERGY = 4000
const MAX_MINERALS = 1000
var minerals : FloatAttribute = FloatAttribute.new("Minerals", 0, 0, MAX_MINERALS)
var antidote : FloatAttribute = FloatAttribute.new("Antidote", 0, 0, MAX_ENERGY)

func _init(_is_child = false, _parent = null).(_is_child, _parent):
	#basics
	name.set_value("Life Plus Herbivore")
	#set colors
	color_one.set_value(Color(1, 0,0))
	color_two.set_value(Color(1,0,0))
	color_three.set_value(Color(1,0,0))
	
	energy = FloatAttribute.new("Energy", 30, 0, MAX_ENERGY)
	#--variables--
	basel_metabolic_rate.set_value(.25)
	reproduction_threshold = MutableFloatAttribute.new("Reproducton threshold", 40, .5, MAX_ENERGY - 1)
	reproduction_gift.set_value(.5)
	reproduction_chance.set_value(.25)
	death_threshold = MutableFloatAttribute.new("Death Threshold (energy)", 0, 0, 0)

	#--brain and habits--
	input_style = HerbavoreCategoriesInutStyle
	input_count = input_style.input_count()
	output_count = 12
	brain = LifeBrainAttribute.new("Brain", null, 1)

	allowed_actions = [RandomWalkAction, SpecificWalkAction, HerbavoreEatPlantAction, HerbavoreAccumulateAntidoteAction,
	PlantShareEnergyAction, PlantShareMineralsAction, CreateWallAction, RemoveWallAction, PushAction] #TODO
	default_habit = [HerbavoreEatPlantAction.new(), RandomWalkAction.new()]
	max_actions_per_habbit.set_value(15)
	calibrate()

func calibrate():
	.calibrate()
	
	if not is_child:
		build_habits()
		brain.set_value(LifeBrain.new(input_count, output_count))

func add_attributes():
	.add_attributes()
	attributes.append_array([minerals,antidote])

func life_tick():
	.life_tick()
	var energv_vs_antidote = energy.get_value() - antidote.get_value()
	energv_vs_antidote = (log(energv_vs_antidote + exp(1)) - 1) / 5
	var r = clamp(1, 0, 1)
	var g = clamp(energv_vs_antidote, 0, 1)
	var b = clamp(0, 0, 1)
	var energy_color = Color(r,g,b)
	
	
	var ratio = energy.get_value() / (minerals.get_value() if minerals.get_value() else .000001)
	if ratio == 0: ratio = .0001
	var mineral_color_scale = log(minerals.get_value() + exp(1) - 1) / 10 
	var mineral_color = energy_color.linear_interpolate(Color(1,1,1) * mineral_color_scale, clamp(1.0/ratio,0,.7))
	color_two.set_value(mineral_color)
	color_one.set_value(mineral_color)


func assemble_child(child_energy):
	var child = .assemble_child(child_energy)
	child.minerals.set_value(0)
	child.antidote.set_value(0)
	return child

func gain_minerals(value):
	minerals.set_value(minerals.get_value() + value)
