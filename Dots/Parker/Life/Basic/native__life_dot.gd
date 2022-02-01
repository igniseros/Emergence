extends LifeDot
class_name NativeLifeDot

var reproduction_energy_thresh = .4
var reproduction_cost = .2
var death_efficeny = .1

func _init():
	#set name
	name = "Native Life"
	#set clors
	color_one = Color(.7,1,.7)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)
	
	energy = .1
	efficency = 300

func tick():
	var choice = floor(randf()*3)
	if choice == 0:
		if energy > reproduction_energy_thresh:
			if reproduce():
				return
	elif choice == 1:
		if not eat():
			walk(PDF.rand_direction())
	elif choice == 2:
		walk(PDF.rand_direction())


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
			return true
	return false

func reproduce():
	#look at the box around myself
	var in_box = PDF.look_at_array(self,PDF.box_around)
	var i = 0
	for dot in in_box:
		#find empty spot
		if not dot is Dot:
			var child = get_script().new() as NativeLifeDot
			#set postion
			child.position = position + PDF.box_around[i]
			#add him to the grid
			grid_node.insert_dot(child)
			#return
			return true
		i+=1
	
	return false

func post_death(g):
	var food = FoodDot.new()
	food.position = position
	food.nutrition = 0.1 + (energy * death_efficeny)
	g.insert_dot(food)
