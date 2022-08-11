extends PushableDot
class_name FoodDot

var nutrition : FloatAttribute = FloatAttribute.new("Nutrition", 10)
#how much less per turn
const decay_rate_l = 0
#how ratio per turn
const decay_rate_e = 1

func _init(nutrients = 10):
	#set name
	name = StringAttribute.new("Name","Food")
	nutrition.set_value(nutrients)
	#set clors
	color_one.set_value(Color(get_nutrition()/400 + .75,get_nutrition()/400 + .75,0))
	color_two.set_value(Color(get_nutrition()/400 + .75,get_nutrition()/400 + .70,0))
	color_three.set_value(Color(get_nutrition()/400 + .75,get_nutrition()/400 + .60,0))

func add_attributes():
	.add_attributes()
	attributes.append_array([nutrition])

func will_tick():
	return true

func get_nutrition():
	return nutrition.get_value()

func tick():
	nutrition.set_value(get_nutrition() - decay_rate_l)
	nutrition.set_value(get_nutrition() * decay_rate_e)
	color_one.set_value(Color(get_nutrition()/400 + .75,get_nutrition()/400 + .75,0))
	color_two.set_value(Color(get_nutrition()/400 + .75,get_nutrition()/400 + .70,0))
	color_three.set_value(Color(get_nutrition()/400 + .75,get_nutrition()/400 + .60,0))
	if _active == false:
		color_one.set_value(Color(1,0,1))
	if get_nutrition() < 0:
		Grid.remove_dot(self)
