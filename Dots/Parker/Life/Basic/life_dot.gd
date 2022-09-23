extends PhysDot
class_name LifeDot

var health : float = 5
var energy : float = 0
var efficency : float = 1
var alive = true
const basil_metabolic_rate = .5
var team : String= ""
var max_age = 20000
const walk_energy = 1
var death_threshhold = .5

func _init():
	#set name
	name = StringAttribute.new("Name","Life")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(1,1,1))
	color_two = ColorAttribute.new("Color 1", Color(1,1,1))
	color_three = ColorAttribute.new("Color 1", Color(0,1,0))

func tick():
	use_energy(basil_metabolic_rate)
	if(age.get_value() > max_age):
		die()
	if(alive):
		life_tick()

func life_tick():
	pass

func will_tick():
	return true

func get_true_efficency():
	return efficency

func use_energy(e , true_use : bool = false, killed = false):
	energy -= float(e) / (1 if true_use else efficency)
	if(energy < death_threshhold):
		die(killed)

func take_damage(d):
	health -= d
	if health <= 0:
		die()

func walk(d : Vector2):
	if(d.length() >= 2):
		return false
	use_energy(walk_energy)
	if energy > 0:
		move(d)
	else:
		die()

func jump(d : Vector2):
	use_energy(d.length_squared() * walk_energy)
	if energy > 0:
		move(d)
	else:
		die()

func die(override_post_death = false):
	if alive:
		alive = false
		Grid.remove_dot(self)
		if not override_post_death:
			post_death()

func post_death():
	pass
