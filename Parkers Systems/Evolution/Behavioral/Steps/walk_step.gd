extends Step
class_name StepWalk

var p = [.5,.5]
func get_name():
	return "Walk"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	dot.walk(PDF.float2dir(p[0],p[1]))

func get_color_mod():
	return Color(0,0,0.05)
