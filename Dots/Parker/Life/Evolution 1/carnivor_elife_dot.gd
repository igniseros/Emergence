extends EvolvingLifeDot
class_name CarnivoreEvolvingLifeDot


func _init():
	randomize()
	#set name
	name = "Carnivore Evolving Life"
	team = "Carnivors"
	#set clors
	color_one = Color(0,0,0)
	color_two = Color(0,0,0)
	color_three = Color(0,0,0)
	
	energy = reproduction_cost
	efficency = 1.5
	
	possible_step_list = [StepAttack,StepRandomWalk,StepRandomJump,StepWait]
	behavior = Behavior.new()
	var attack_step1 = StepAttack.new()
	attack_step1.p = [.2,.2]
	var attack_step2 = StepAttack.new()
	attack_step2.p = [.3,.3]
	var attack_step3 = StepAttack.new()
	attack_step3.p = [.4,.4]
	behavior.steps.append_array([attack_step1,StepRandomWalk.new(),attack_step2,StepRandomWalk.new(),attack_step3,StepRandomWalk.new()])
