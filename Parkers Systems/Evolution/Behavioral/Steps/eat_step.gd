extends Step
class_name StepEat

var p = []
func _init():
	name = "Eat"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	#dot.use_energy(.1)
	#look at the box around myself	
	var in_box = PDF.look_at_array(dot,PDF.box_around)
	for ndot in in_box:
		#if i find food
		if ndot is FoodDot:
			ndot = ndot as FoodDot
			#add energy
			dot.energy += ndot.nutrition
			#remove dot
			dot.grid_node.remove_dot(ndot)
			#end turn
			return

func get_color_mod():
	return Color(.5,1,0)
