extends LifeDot
class_name EvolvingLifeDot

var behavior : Behavior
var team_change_chance = 1
var reproduction_energy_thresh = 2
var reproduction_cost = 4
var reproduction_chance = .85
const death_efficeny = .8
var mutation_chance = .5
var mutation_scale_p = .33
var mutation_scale_s = 5
var generation = 0
var mutations = 0
var possible_step_list = [StepEat, StepWalk, StepAttack]

func _init():
	randomize()
	#set name
	name = StringAttribute.new("Name","Evolving Life")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(0,0,0))
	color_two = ColorAttribute.new("Color 2", Color(0,0,0))
	color_three =ColorAttribute.new("Color 3",  Color(0,0,0))

	energy = reproduction_cost
	death_threshhold = reproduction_cost / 8
	efficency = 100

	behavior = Behavior.new()
	behavior.steps.append_array([StepEat.new(), StepWalk.new()])

func life_tick():
	if energy > (reproduction_cost + reproduction_energy_thresh) and randf() < reproduction_chance:
		reproduce()
	else:
		var input_color = behavior.step(self).get_color_mod()
		var old_color = color_one.get_value()
		color_one.set_value(input_color * .1 + old_color * .9)

func reproduce():
	#look at the box around myself
	var in_box = PDF.look_at_array(self,PDF.box_around_self(3))
	for m in range(in_box.size()):
		var i = floor(rand_range(0,in_box.size()))
		var dot = in_box[i]
		#find empty spot
		if not dot is PhysDot:
			use_energy(reproduction_cost, true)
			if alive:
				var child = create_child(position + PDF.box_around_self(3)[i])
				#possibly mutate
				if randf() <= mutation_chance:
					mutate_child(child)
				#set color
				for step in child.behavior.steps:
					child.color_one.set_value(step.get_color_mod() / child.behavior.steps.size())
				#add him to the grid
				Grid.insert_dot(child)
				#return
				return true
			else:
				return false
		i+=1

	return false

func post_death():
	var energy_left = (energy) * death_efficeny
	if(energy_left > 0):
		var food = FoodDot.new()
		food.position = position
		food.nutrition.set_value(energy_left)
		Grid.insert_dot(food)

func mutate_child(child : LifeDot):
	var newBegavior = Behavior.new()
	for step in behavior.steps:
		step = step as Step
		newBegavior.steps.append(step.duplicate())

	child.behavior = newBegavior
	if randf() < team_change_chance:
		if randf() < .5:
			child.team += char(ceil(rand_range(64,68))) #add char
		else:
			child.team.erase(child.team.length() - 1, 1) # remove char
	child.mutations = mutations + 1
	child.behavior.mutate_steps(mutation_scale_s,possible_step_list)
	child.behavior.mutate_parameters(mutation_scale_p)
	child.mutation_scale_s = clamp(child.mutation_scale_s * (1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p),.0001,100)
	child.max_age = clamp(child.max_age * (1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p),1,9999999)
	child.mutation_scale_p = clamp(child.mutation_scale_p * (1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p),.0001,1)
	child.team_change_chance = clamp(child.team_change_chance + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,.0001,1)
	child.mutation_chance = clamp(child.mutation_chance +rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p,0.000001,1)
	child.reproduction_chance = clamp(child.reproduction_chance * (1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p),0.001,.9)
	child.reproduction_cost = clamp(child.reproduction_cost * (1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p),.001,100000)
	child.reproduction_energy_thresh = clamp(child.reproduction_energy_thresh * (1 + rand_range(-1*mutation_scale_p,mutation_scale_p) * mutation_scale_p),0.01,10000000)
	return child

func create_child(pos):
	#update tags
	var child = get_script().new() as EvolvingLifeDot
	child.team = team
	child.generation += 1 + generation
	child.mutations = mutations
	child.behavior = behavior
	#set postion
	child.position =  pos
	#update mutations stuff:
	child.mutation_chance = mutation_chance
	child.mutation_scale_p = mutation_scale_p
	child.mutation_scale_s = mutation_scale_s
	#update reporduction
	child.reproduction_chance = reproduction_chance
	child.reproduction_cost = reproduction_cost
	child.reproduction_energy_thresh = reproduction_energy_thresh	
	child.max_age = max_age
	#update energy
	child.energy = child.reproduction_cost
	child.death_threshhold = child.reproduction_cost / 3
	return child

func _on_click():
	print("-----------------")
	print("Name" + str(name))
	print("Energy" + str(energy))
	print(behavior.steps)
