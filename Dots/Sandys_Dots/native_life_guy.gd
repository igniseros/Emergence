extends LifeGuy
class_name NativeLifeGuy

var reproduction_energy_thresh = 2
var reproduction_cost = .5
var death_efficeny = .25

func _init():
	#set name
	name = "Native Life"
	#set clors
	color_one = Color(.7,1,.6)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)
	
	energy = reproduction_cost
	efficency = 160

func tick(): # randomly choose to try to reproduce or stay, eat or walk, or walk
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
			var child = get_script().new() as NativeLifeGuy
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
