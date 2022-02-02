extends Step
class_name StepRandomWalk

var p = []
func get_name():
	return "Random Walk"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	dot.walk(PDF.rand_direction())

func get_color_mod():
	return Color(0,0,0.05)
