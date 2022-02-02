extends Step
class_name StepRandomJump

var scale = 4

var p = [0.5,0.5]
func get_name():
	return "Random Jump"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	dot.jump(Vector2(ceil(p[0]*(scale+1))-(scale/2 + 1), ceil(p[1]*(scale+1))-((scale/2 + 1)) ))

func get_color_mod():
	return Color(0,0,1)
