extends Step
class_name StepWait

var p = []
func _init():
	name = "Wait"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	pass
