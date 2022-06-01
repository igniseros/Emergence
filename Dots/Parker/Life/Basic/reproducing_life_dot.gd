extends LifeDot
class_name ReproducingLifeDot

var max_health = 18
var reproduction_threshold = 2
var descendant_energy = 2
var mutation_scale = .1

func _init():
	#set name
	name = "Reproducing Life"
	#set clors
	color_one = Color(1,1,1)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)
	
	#health is inverse of starting energy
	energy = descendant_energy
	max_health = 20 - descendant_energy
	health = max_health
	


func tick():
	.tick()
	if energy > descendant_energy + reproduction_threshold:
		attempt_reproduce()

func attempt_reproduce():
	var i = 0
	var directions = PDF.look_at_array(self,PDF.box_around_self(1))
	for spot_looked_at in directions:
		if (spot_looked_at is Dot and spot_looked_at.name == "Dot"):
			grid_node.remove_dot(spot_looked_at)
			reproduce(position + directions[i])
		elif spot_looked_at is Dot:
			reproduce(position + directions[i])
		
		i+=1
			

func reproduce(baby_position : Vector2):
	var baby = get_script().new() as LifeDot
	baby.position = baby_position
	
	baby.max_health = 20 - baby.descendent_energy
	baby.health = max_health
	replicate_parent_features(baby)
	
	baby.health = 20 - descendant_energy
	grid_node.insert_dot(baby)

func replicate_parent_features(baby : LifeDot):
	baby.reproduction_threshold = reproduction_threshold
	baby.descendant_energy = descendant_energy

func mutate_features(baby : LifeDot):
	baby.reproduction_threshold = clamp(baby.reproduction_threshold + (randf()*mutation_scale),0,200)
	baby.descendant_energy = clamp(baby.descendant_energy + (randf()*mutation_scale),.1,19.99)
