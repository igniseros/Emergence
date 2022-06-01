extends ReproducingLifeDot
class_name LifeWithBrain

var inputs = 0
var outputs = 0
var brain : SimpleBrain 

# plan:
# inputs : arbitrary
# outputs : 18 [two types of action per direction]

func _init():
	#set name
	name = "Brain Life"
	#set clors
	color_one = Color(1,1,1)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)
	
	#health is inverse of starting energy
	energy = descendant_energy
	health = 20 - descendant_energy
	brain = SimpleBrain.new(inputs,outputs,0,true,1)

func affect_brain_natural(input : Vector, amount : float):
	brain.adjust_behavior_natural(input,amount,0,0)

func affect_brain_forced(input: Vector, amount : float, output : int):
	brain.adjust_behavior_forced(input,amount,0,output, 0)
