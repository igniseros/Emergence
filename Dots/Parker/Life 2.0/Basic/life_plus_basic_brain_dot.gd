extends LifePlusBaseDot
class_name LifePlusBrainDot

#--variables--
var basel_metabolic_rate : FloatAttribute = FloatAttribute.new("Basel Metabolic Rate", 1)
var reproduction_threshold : MutableFloatAttribute = MutableFloatAttribute.new("Reproduction threshold", 10, ALMOST_ZERO, LARGE_NUMBER)
var reproduction_gift : MutableFloatAttribute = MutableFloatAttribute.new("Reproduction Gift", .5, ALMOST_ZERO, ALMOST_ONE)
var death_threshold : MutableFloatAttribute = MutableFloatAttribute.new("Death Threshold (energy)", 4, ALMOST_ZERO, LARGE_NUMBER)

#--brain and habits--
var input_style = ColorsInputStyle
var input_count = input_style.input_count()
var output_count = 8
var brain : LifeBrainAttribute = LifeBrainAttribute.new("Brain", null, 1)
var rand_brain_on_ui_insert : BooleanAttribute = BooleanAttribute.new("Random brain on UI insert", true)
var mem = Memory.new(1)
var last_input : Vector

#---BONUS BRAINS---
var reproduction_brain = LifeBrainAttribute.new("Reproduction Brain", null, 1)
var reproduction_direction_brain = LifeBrainAttribute.new("Reproduction Direction Brain", null, 1)

var allowed_actions = [DieAction, EatAction, RandomWalkAction, AttackAction, SpecificWalkAction, PushAction, 
RemoveWallAction, CreateWallAction, ChangeColorTwoAction, ChangeColorThreeAction, DropFoodAction]
var default_habit = [EatAction.new(),RandomWalkAction.new()]
var max_actions_per_habbit : IntAttribute = IntAttribute.new("Max Habbits", 8,0)
var habits = HabbitAttribute.new("Habits", allowed_actions, max_actions_per_habbit.get_value())

func _init(_is_child = false, _parent = null).(_is_child, _parent):
	name.set_value("Life Plus Brain")
	#set colors
	color_one.set_value(Color(1,.5,.5))
	color_two.set_value(Color(1,.5,.5))
	color_three.set_value(Color(1,.5,.5))
	calibrate()

func calibrate():
	.calibrate()
	
	if not is_child:
		build_habits()
		brain.set_value(LifeBrain.new(input_count, output_count))
		reproduction_brain.set_value(LifeBrain.new(input_count, 2))
		reproduction_direction_brain.set_value(LifeBrain.new(input_count, 8))

func calc_color() -> Color:
	var c = Color(0,0,0,0)
	
	for h in habits.get_value():
		c += h.get_color() * (1 / float(habits.get_value().size()))
	
	return c

func build_habits():
	habits.set_value([])
	habits.max_actions_per_habbit = max_actions_per_habbit.get_value()
	for i in range(output_count):
		habits.get_value().append(Habit.new(default_habit, max_actions_per_habbit.get_value()))

func add_attributes():
	.add_attributes()
	attributes.append_array([rand_brain_on_ui_insert,basel_metabolic_rate, max_actions_per_habbit])

func add_mutable_attributes():
	.add_mutable_attributes()
	mutable_attributes.append_array([reproduction_gift,reproduction_threshold,death_threshold,habits, brain, reproduction_brain, reproduction_direction_brain])

func gather_inputs() -> Vector:
	return input_style.gather_inputs(self)

func assemble_child(child_energy):
	var child = .assemble_child(child_energy)
	child.brain.set_value(brain.copy().get_value())
	child.reproduction_brain.set_value(reproduction_brain.copy().get_value())
	child.reproduction_direction_brain.set_value(reproduction_direction_brain.copy().get_value())
	child.habits.set_value([])
	for h in habits.get_value():
		child.habits.get_value().append(h.copy())
	child.color_one.set_value(calc_color())
	return child

func use_energy(amount : float):
	.use_energy(amount)
	if energy.get_value() <= death_threshold.get_value():
		die()

func life_tick():
	use_energy(basel_metabolic_rate.get_value())
	
	if alive.get_value():
		var inputs = gather_inputs()
		
		if energy.get_value() > reproduction_threshold.get_value() and \
		reproduction_brain.get_habit_index(inputs):
			reproduce(reproduction_gift.get_value(), reproduction_direction_brain.get_habit_index(inputs))
		else:
			#chooses the habit to perform and executes on it
			var index = brain.get_habit_index(inputs)
			var chosen_habbit : Habit = habits.get_value()[index]
			chosen_habbit.execute(self)
			mem.add_mem(chosen_habbit)
			color_one.set_value(color_one.get_value() * .9 + chosen_habbit.get_color() * .1)

func _on_ui_insert():
	if rand_brain_on_ui_insert.get_value():
		brain.new_brain()
		reproduction_brain.new_brain()
		reproduction_direction_brain.new_brain()
