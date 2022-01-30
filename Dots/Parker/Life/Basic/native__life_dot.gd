extends LifeDot
class_name NativeLifeDot

func _init():
	#set name
	name = "Native Life"
	#set clors
	color_one = Color(.7,1,.7)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)
	
	energy = 1
	efficency = 50

func tick():
	var choice = randf()
	if(choice > .5):
		#walk randomly
		walk(PDF.rand_direction())
	else:
		eat()

func eat():
	#look at the box around myself
	var in_box = PDF.look_at_array(self,PDF.box_around)
	for dot in in_box:
		#if i find food
		if dot is FoodDot:
			dot = dot as FoodDot
			#add energy
			energy += dot.nutrition
			#remove dot
			grid_node.remove_dot(dot)
			#end turn
			return
