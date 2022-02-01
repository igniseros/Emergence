extends Step
class_name StepAttack

var kills = 0
const damage_scale = 3
var efficency = .25
#repeats[1,10] and damage[1-15]
var p = [0.2, 0.2]

func _init():
	name = "Attack"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	var repeats = ceil(p[0] * 10)
	var damage = p[1]*damage_scale
	var in_box_around = PDF.look_at_array(dot,PDF.box_around)
	
	for i in range(repeats):
		var spot = floor(rand_range(0,8))
		#get random spot and attempt attack
		if in_box_around[spot] is LifeDot:
			dot.use_energy(damage / dot.efficency)
			var before = in_box_around[spot].energy
			in_box_around[spot].use_energy(damage * dot.efficency)
			var diffrence = before - in_box_around[spot].energy
			dot.energy += diffrence * efficency

func get_color_mod():
	return Color(1,0,0)