extends PhysDot
class_name LifeDot

var energy : float = 0
var efficency : float = 1
var alive = true

func _init():
	#set name
	name = "Life"
	#set clors
	color_one = Color(1,1,1)
	color_two = Color(1,1,1)
	color_three = Color(0,1,0)

func tick():
	pass

func will_tick():
	return true

func use_energy(e):
	energy -= float(e) / efficency

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

func die():
	if alive:
		alive = false
		post_death()

func post_death():
	pass
