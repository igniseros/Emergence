extends Step
class_name StepAttack

var p = [0.2, 0.2]

func get_name():
	return "Attack"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	pass

func get_color_mod():
	return Color(1,0,0)
