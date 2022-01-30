extends PhysDot
class_name LifeDot

var energy = 0
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

func walk(d : Vector2):
	if(d.length() >= 2):
		return false
	energy-=1
	if energy > 0:
		move(d)
	else:
		die()
	

func jump():
	pass

func die():
	alive = false
	post_death()

func post_death():
	pass
