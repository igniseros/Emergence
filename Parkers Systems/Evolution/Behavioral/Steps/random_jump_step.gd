extends Step
class_name StepRandomJump

var p = [0.5,0.5]
func _init():
	name = "Random Jump"

func get_parameters():
	return p

func set_parameters(x):
	p = x

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	dot.jump(Vector2(ceil(p[0]*11)-6, ceil(p[1]*11)-6 ))
