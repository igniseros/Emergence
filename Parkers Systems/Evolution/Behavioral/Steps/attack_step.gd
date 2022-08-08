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
	dot.use_energy(5)
	var dir = PDF.float2dir(randf(), randf())
	while dir == Vector2(0,0): dir = PDF.float2dir(randf(), randf())
	var victim = Grid.get_at(dot.position + dir)
	if victim is LifeDot:
		dot.energy += .25
		victim.use_energy(.5, true)

func get_color_mod():
	return Color(1,0,0)
