extends EvolvingLifeDot
class_name HerbavoreEvolvingLifeDot


func _init():
	randomize()
	#set name
	name = "Herbavore Evolving Life"
	#set clors
	color_one = Color(0,0,0)
	color_two = Color(0,0,0)
	color_three = Color(0,0,0)
	
	energy = reproduction_cost
	efficency = 50
	basil_metabolic_rate *= reproduction_cost
	
	possible_step_list = [StepEat,StepRandomWalk,StepRandomJump]
	behavior = Behavior.new()
	behavior.steps.append_array([StepEat.new(),StepRandomWalk.new()])
	
