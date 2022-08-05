extends PhysDot
class_name FoodDot

var nutrition = 1
#how much less per turn
const decay_rate_l = 0
#how ratio per turn
const decay_rate_e = 1

func _init():
	#set name
	name = StringAttribute.new("Name","Food")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(1,1,0))
	color_two = ColorAttribute.new("Color 2", Color(1,.5,0))
	color_three = ColorAttribute.new("Color 3", Color(1,1,0))

func will_tick():
	return true

func get_nutrition():
	return nutrition

func tick():
	nutrition -= decay_rate_l
	nutrition *= decay_rate_e
	color_one.set_value(Color(nutrition/200 + .5,nutrition/200 + .5,0))
	if nutrition < 0:
		Grid.remove_dot(self)
