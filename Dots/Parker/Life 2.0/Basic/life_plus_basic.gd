extends LifePlusBaseDot
class_name LifePlusBasicDot

var chance_to_eat = MutableFloatAttribute.new("Chance to eat", .85, ALMOST_ZERO, .95)
var chance_to_reproduce = MutableFloatAttribute.new("Chance to reproduce", .5, ALMOST_ZERO, ALMOST_ONE)

func  _init(_is_child = false, _parent = null).(_is_child, _parent):
	#set name
	name.set_value("Life Plus Basic")
	#set colors
	color_one.set_value(Color(0,1,0))
	color_two.set_value(Color(0,1,0))
	color_three.set_value(Color(0,1,0))
	#set up
	calibrate()

func calibrate():
	.calibrate()
	energy.set_value(10)
	color_one.set_value(Color(0, chance_to_eat.get_value(), 1 - chance_to_eat.get_value()))

func add_mutable_attributes():
	.add_mutable_attributes()
	mutable_attributes.append_array([chance_to_eat,chance_to_reproduce])

func life_tick():
	if energy.get_value() > 10 and randf() < chance_to_reproduce.get_value() and reproduce():
		pass
	elif randf() < chance_to_eat.get_value():
		for m in PDF.look_at_array(self, PDF.box_around):
			if m is FoodDot:
				Grid.remove_dot(m)
				use_energy(-1 * m.nutrition.get_value())
	else:
		use_energy(1)
		move(PDF.float2dir(randf(),randf()))

func assemble_child(child_energy):
	var child = .assemble_child(child_energy)
	child.color_one.set_value(Color(0, chance_to_eat.get_value(), 1 - chance_to_eat.get_value()))
	return child

func die(drop_food = true):
	.die(drop_food)
	var food = FoodDot.new()
	food.nutrition.set_value(2)
	food.position = position
	Grid.insert_dot(food)
