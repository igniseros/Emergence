extends Step
class_name StepAttack

#repeats[1,10] and damage[.1-1.5]
var p = [0.5, 0.5]

func _init():
	name = "Attack"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	dot.color_one.r = 1*p[0]
	var repeats = ceil(p[0] * 10)
	var damage = ceil(p[1]*15)/10.0
	var in_box_around = PDF.look_at_array(dot,PDF.box_around)
	
	for i in range(repeats):
		var spot = floor(rand_range(0,8))
		#get random spot and attempt attack
		if in_box_around[spot] is LifeDot:
			dot.use_energy(damage)
			in_box_around[spot].die()
