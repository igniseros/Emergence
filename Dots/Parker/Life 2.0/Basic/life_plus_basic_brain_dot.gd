extends LifePlusBaseDot
class_name LifePlusBrainDot

#--variables--
var basel_metabolic_rate : FloatAttribute = FloatAttribute.new("Basel Metabolic Rate", 1)
var reproduction_threshold : MutableFloatAttribute = MutableFloatAttribute.new("Reproduction threshold", 10, ALMOST_ZERO, LARGE_NUMBER)
var reproduction_gift : MutableFloatAttribute = MutableFloatAttribute.new("Reproduction Gift", .5, ALMOST_ZERO, ALMOST_ONE)
var reproduction_chance : MutableFloatAttribute = MutableFloatAttribute.new("Reproduction Chance", .9, ALMOST_ZERO, ALMOST_ONE)
var death_threshold : MutableFloatAttribute = MutableFloatAttribute.new("Death Threshold (energy)", 4, ALMOST_ZERO, LARGE_NUMBER)

#--brain and habits--
var input_count = 25
var output_count = 5
var brain : LifeBrainAttribute = LifeBrainAttribute.new("Brain", null, 1)

var habits = []
var allowed_actions = [EatAction, RandomWalkAction, AttackAction]
var default_habit = [EatAction.new(),RandomWalkAction.new()]

func _init(_is_child = false, _parent = null).(_is_child, _parent):
	name.set_value("Life Plus Brain")
	#set colors
	color_one.set_value(Color(1,.5,.5))
	color_two.set_value(Color(1,.5,.5))
	color_three.set_value(Color(1,.5,.5))
	calibrate()

func calibrate():
	.calibrate()
	energy.set_value(10)
	color_one.set_value(calc_color())
	
	if not is_child:
		build_habbits()
		brain.set_value(LifeBrain.new(input_count, output_count))

func calc_color() -> Color:
	var c = Color(0,0,0,0)
	
	for h in habits:
		c += h.get_color() * (1 / float(habits.size()))
	
	return c

func build_habbits():
	for i in range(output_count):
		habits.append(Habit.new(default_habit))

func add_attributes():
	.add_attributes()
	attributes.append(basel_metabolic_rate)

func add_mutable_attributes():
	.add_mutable_attributes()
	mutable_attributes.append_array([brain,reproduction_gift,reproduction_chance,reproduction_threshold,death_threshold])

#mutate including brain
func mutate():
	.mutate()
	brain.mutate(mutation_chance.get_value(), mutation_scale.get_value())
	for h in habits:
		h.mutate(mutation_chance.get_value(), mutation_scale.get_value(), allowed_actions)

func gather_inputs() -> Vector:
	#inputs here are the colors of the dots around the current dot
	var inputs = []
	for dot in PDF.look_at_array(self, PDF.box_around):
		if dot is Dot:
			inputs.append(dot.color_one.get_value().r)
			inputs.append(dot.color_one.get_value().g)
			inputs.append(dot.color_one.get_value().b)
		else:
			inputs.append_array([0,0,0])
	inputs.append(energy.get_value()/reproduction_threshold.get_value())
	return Vector.new(inputs)

func assemble_child(child_energy):
	var child = .assemble_child(child_energy)
	child.brain.set_value(brain.copy().get_value())
	child.habits = []
	for h in habits:
		child.habits.append(h.copy())
	child.color_one.set_value(calc_color())
	return child

func use_energy(amount : float):
	.use_energy(amount)
	if energy.get_value() <= death_threshold.get_value():
		die()

func life_tick():
	use_energy(basel_metabolic_rate.get_value())
	
	if energy.get_value() > reproduction_threshold.get_value():
		reproduce(reproduction_gift.get_value())
	else:
		#chooses the habit to perform and executes on it
		var chosen_habbit : Habit = habits[brain.get_habit_index(gather_inputs())]
		chosen_habbit.execute(self)
		color_one.set_value(color_one.get_value() * .9 + chosen_habbit.get_color() * .1)
