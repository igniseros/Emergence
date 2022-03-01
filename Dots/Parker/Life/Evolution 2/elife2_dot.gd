extends EvolvingLifeDot


func _init():
	randomize()
	#set name
	name = "Evolving Life"
	#set clors
	color_one = Color(0,0,0)
	color_two = Color(0,0,0)
	color_three = Color(0,0,0)
	
	energy = reproduction_cost
	efficency = 1
	
	behavior = Behavior.new()
	behavior.steps.append_array([StepEat.new(),StepRandomWalk.new(),StepAttack.new(),StepRandomWalk.new(),StepEat.new(),StepRandomWalk.new()])

func life_tick():
	if energy > (reproduction_cost + reproduction_energy_thresh) and randf() < reproduction_chance:
		reproduce()
