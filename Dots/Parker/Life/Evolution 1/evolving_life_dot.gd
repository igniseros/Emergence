extends LifeDot
class_name EvolvingLifeDot

var behavior : Behavior
var reproduction_energy_thresh = 4
var reproduction_cost = 2
var death_efficeny = .5
var reproduction_chance = .5
var mutation_scale_p = .9
var mutation_scale_s = .9
var mutation_chance = 1
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
	basil_metabolic_rate *= reproduction_cost
	
	behavior = Behavior.new()
	behavior.steps.append_array([StepEat.new(),StepRandomWalk.new()])
	
func life_tick():
	if energy > reproduction_cost + reproduction_energy_thresh and randf() < reproduction_chance:
		while energy > reproduction_cost + reproduction_energy_thresh:
			if not reproduce(): break
	else:
		behavior.step(self)

func reproduce():
	#look at the box around myself
	var in_box = PDF.look_at_array(self,PDF.box_around_self(3))
	for m in range(in_box.size()):
		var i = floor(rand_range(0,in_box.size()))
		var dot = in_box[i]
		#find empty spot
		if not dot is Dot:
			energy -= reproduction_cost	
			var child = get_script().new() as EvolvingLifeDot
			child.generation += 1 + generation
			var newBegavior = Behavior.new()
			for step in behavior.steps:
				step = step as Step
				newBegavior.steps.append(step.duplicate())
			child.behavior = newBegavior
			#set postion
			child.position = position + PDF.box_around_self(3)[i]
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
	child.mutation_scale_s = clamp(child.mutation_scale_s + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,.0001,100)
	child.mutation_scale_p = clamp(child.mutation_scale_p + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,.0001,1)
	child.mutation_chance = clamp(child.mutation_chance +rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,0.0001,1)
	child.reproduction_chance = clamp(child.reproduction_chance + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,0.001,1)
	child.reproduction_cost = clamp(child.reproduction_cost + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,0.0001,100000)
	child.reproduction_energy_thresh = 1 + clamp(child.reproduction_energy_thresh + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,0.0001,10000000)
	return child
