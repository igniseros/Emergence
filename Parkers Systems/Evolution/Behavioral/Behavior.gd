class_name Behavior

var steps : Array = []
var spot = 0

func step(dot : LifeDot):
	spot = spot % steps.size()
	var s = steps[spot] as Step
	s.play(dot)
	spot = (spot + 1) % steps.size()
	return s

func do(dot : LifeDot):
	for i in range(steps.size()):
		if(not dot.alive): break
		var s = steps[i] as Step
		s.play(dot)

func mutate_parameters(delta):
	for step in steps:
		step = step as Step
		for i in range(step.get_parameters().size()):
			var p = step.p[i] as float
			var d = delta * (randf() - .5) #random scaled by delta * (-.5,.5)
			step.p[i] = clamp(p + d,0,1) #add them together

func mutate_steps(scale, step_list : Array):
	#random chance
	var i = randf()
	#if passes
	if i < scale: i=1 #add random amount
	#scale just means more edits
	while i >= 1:
		i-=1
		var choice = floor(rand_range(0,4))
		var insert_spot = floor(rand_range(0,steps.size()))
		#choice one is insertrandom step
		if choice <= 0:
			steps.append(step_list[floor(rand_range(0,step_list.size()))].new())
		#remove random add random
		if choice == 1:
			steps.remove(insert_spot)
			steps.insert(insert_spot,step_list[floor(rand_range(0,step_list.size()))].new())
		#random remove
		if choice >= 3 and steps.size() > 1:
			steps.remove(insert_spot)

