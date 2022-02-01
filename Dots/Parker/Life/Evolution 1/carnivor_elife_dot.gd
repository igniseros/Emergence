extends EvolvingLifeDot
class_name CarnivoreEvolvingLifeDot


func _init():
	randomize()
	#set name
	name = "Carnivore Evolving Life"
	#set clors
	color_one = Color(0,0,0)
	color_two = Color(0,0,0)
	color_three = Color(0,0,0)
	
	energy = reproduction_cost
	efficency = 50
	basil_metabolic_rate *= reproduction_cost
	
	possible_step_list = [StepAttack,StepRandomWalk,StepRandomJump]
	behavior = Behavior.new()
	var attack_step = StepAttack.new()
	attack_step.p = [.8,.8]
	behavior.steps.append_array([attack_step,StepRandomWalk.new()])
	
