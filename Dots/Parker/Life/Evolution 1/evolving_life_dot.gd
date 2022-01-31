extends LifeDot
class_name EvolvingLifeDot

var behavior : Behavior
var reproduction_energy_thresh = 15
var reproduction_cost = 7
var death_efficeny = .5
var reproduction_chance = .5
var mutation_scale_p = .15
var mutation_scale_s = 10
var generation = 0
var possible_step_list = [StepEat,StepEat,StepWait,StepRandomWalk,StepRandomJump,StepAttack]
var children = []

func _init():
	randomize()
	#set name
	name = "Evolving Life"
	#set clors
	color_one = Color(0,0,0)
	color_two = Color(0,0,0)
	color_three = Color(0,0,0)
	
	energy = reproduction_cost
	efficency = 2
	
	behavior = Behavior.new()
	behavior.steps.append_array([StepRandomWalk.new(),StepEat.new()])
	
func tick():
	if energy > reproduction_energy_thresh and randf() < reproduction_chance:
		reproduce()
	else:
		behavior.step(self)

func reproduce():
	#look at the box around myself
	var in_box = PDF.look_at_array(self,PDF.box_around)
	var i = 0
	for dot in in_box:
		#find empty spot
		if not dot is Dot:
			var child = get_script().new() as EvolvingLifeDot
			#set postion
			child.position = position + PDF.box_around[i]
			child.generation += 1 + generation
			child.behavior.mutate_steps(mutation_scale_s,possible_step_list)
			child.behavior.mutate_parameters(mutation_scale_p)
			child.mutation_scale_s += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
			child.mutation_scale_p += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
			child.reproduction_chance += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
			child.reproduction_cost += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
			child.reproduction_energy_thresh *= 1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
			child.color_one += Color(rand_range(0,.1),rand_range(0,.1),rand_range(0,.1))
			#add him to the grid
			grid_node.insert_dot(child)
			children.append(child)
			energy -= reproduction_cost
			
			#return
			return true
		i+=1
	
	return false

func post_death():
	var g = grid_node
	grid_node.remove_dot(self)
	var food = FoodDot.new()
	food.position = position
	food.nutrition = reproduction_cost + (energy * death_efficeny)
	g.insert_dot(food)
