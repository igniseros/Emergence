extends Step
class_name StepRandomWalk

var p = []
func _init():
	name = "Random Walk"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	dot.walk(PDF.rand_direction())
