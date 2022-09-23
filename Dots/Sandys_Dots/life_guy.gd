extends PhysDot
class_name LifeGuy

var energy : float = 0
var efficency : float = 1
var alive = true
var basil_metabolic_rate = 1

func _init():
	#set name
	name = "Life"
	#set clors
	color_one = Color(1,0,1)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)

func tick():
	use_energy(basil_metabolic_rate)
	if(alive):
		life_tick()

func life_tick():
	pass

func will_tick():
	return true

func use_energy(e, killed = false):
	energy -= float(e) / efficency
	if(energy < 0):
		die(killed)

func walk(d : Vector2):
	if(d.length() >= 2):
		return false
	use_energy(1)
	if energy > 0:
		move(d)
	else:
		die()

func jump(d : Vector2):
	use_energy(d.length_squared())
	if energy > 0:
		move(d)
	else:
		die()

func die(killed = false):
	if alive:
		alive = false
		var g = grid_node
		grid_node.remove_dot(self)
		if not killed:
			post_death(g)

func post_death(g):
	pass
