extends NativeLifeDot
class_name ParasiteDot


# reproduce after ~8 ticks of being pregnant

var isPregnant : bool = false

func _init():
	#set name
	name = "Parasite"
	#set clors
	color_one = Color8(105, 53, 53)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)
	
	energy = reproduction_cost
	efficency = 160
	reproduction_energy_thresh = 1
	reproduction_cost = .2
	death_efficeny = .5

func tick(): # randomly choose to try to reproduce or stay, eat or walk, or walk
	var choice = floor(randf()*3)
	if energy > reproduction_energy_thresh:
		var mating_tries = floor(randf()*4)
		try_to_mate(mating_tries) # energy use!!!!!!!!
	if choice == 0:
		pass
	elif choice == 1:
		if not eat():
			walk(PDF.rand_direction())
	elif choice == 2:
		walk(PDF.rand_direction())

func try_to_mate(int numOfTries):
	var tries = range(0, numOfTries)
	var success = floor(randf()*2)
	for i in tries:
		if success == 1:
			mate()
			return
		else:
			success = floor(randf()*2)
	

func mate():
	#look at the box around myself
	var box = PDF.look_at_array(self,PDF.box_around)
	var i = 0
	for dot in box:
		#look for non-pregnant mate
		if dot is ParasiteDot and not dot.isPregnant:
			isPregnant = true
