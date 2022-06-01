#extends EvolvingLifeDot
#class_name HerbavoreEvolvingLifeDot
#
#
#func _init():
#	randomize()
#	#set name
#	name = "Herbavore Evolving Life"
#	team = "herbivors"
#	#set clors
#	color_one = Color(0,0,0)
#	color_two = Color(0,0,0)
#	color_three = Color(0,0,0)
#
#	energy = reproduction_cost
#	efficency = 1.5
#
#	possible_step_list = [StepEat,StepWalk,StepWait]
#	behavior = Behavior.new()
#	behavior.steps.append_array([StepEat.new(),StepWalk.new(),StepEat.new(),StepWalk.new(),StepEat.new(),StepWalk.new()])
#
#
#	reproduction_energy_thresh = 2
#	reproduction_cost = 3
#
