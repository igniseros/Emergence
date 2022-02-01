extends LifeDot
class_name EvolvingLifeDot

var behavior : Behavior
var reproduction_energy_thresh = 2.5
var reproduction_cost = 2
var death_efficeny = .5
var reproduction_chance = .5
var mutation_scale_p = .1
var mutation_scale_s = .2
var mutation_chance = .7
var generation = 0
var mutations = 0
var possible_step_list = [StepEat,StepAttack,StepRandomWalk,StepRandomJump]
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
	efficency = 50
	
	behavior = Behavior.new()
	behavior.steps.append_array([StepEat.new(),StepRandomWalk.new()])
	
func life_tick():
	if energy > reproduction_energy_thresh and randf() < reproduction_chance:
		while energy > reproduction_energy_thresh:
			if not reproduce(): break
	else:
		behavior.step(self)

func reproduce():
	#look at the box around myself
	var in_box = PDF.look_at_array(self,PDF.box_around)
	var i = 0
	for dot in in_box:
		#find empty spot
		if not dot is Dot:
			energy -= reproduction_cost	
			var child = get_script().new() as EvolvingLifeDot
			child.generation += 1 + generation
			var newBegavior = Behavior.new()
			newBegavior.steps =  behavior.steps.duplicate()
			child.behavior = newBegavior
			#set postion
			child.position = position + PDF.box_around[i]
			#possibly mutate
			if randf() <= mutation_chance:
				child = mutate_child(child)
			#set color
			for step in child.behavior.steps:
				child.color_one += step.get_color_mod() / child.behavior.steps.size()
			#add him to the grid
			grid_node.insert_dot(child)
			children.append(child)
			
			#return
			return true
		i+=1
	
	return false

func post_death(g):
	var food = FoodDot.new()
	food.position = position
	food.nutrition = reproduction_cost + (energy * death_efficeny)
	g.insert_dot(food)

func mutate_child(child):
	child.mutations = mutations + 1
	child.behavior.mutate_steps(mutation_scale_s,possible_step_list)
	child.behavior.mutate_parameters(mutation_scale_p)
	child.mutation_scale_s += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
	child.mutation_scale_p += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
	child.reproduction_chance += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
	child.reproduction_cost += rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
	child.reproduction_energy_thresh *= 1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p
	return child
