extends PhysDot
class_name FoodDot

var nutrition = 5
#how much less per turn
const decay_rate_l = 0
#how ratio per turn
const decay_rate_e = 1

func _init():
	#set name
	name = "Food"
	#set clors
	color_one = Color(1,1,0)
	color_two = Color(1,.5,0)
	color_three = Color(1,1,0)

func will_tick():
	return true
	

func tick():
	nutrition -= decay_rate_l
	nutrition *= decay_rate_e
	if nutrition < 0:
		Grid.remove_dot(self)
