extends PhysDot
class_name BugDot

var direction = Vector2(0,1)

func _init():
	#set name
	name = "Bug"
	#set clors
	color_one = Color(.2,.3,.4)
	color_two = Color(.50,.50,.50)
	color_three = Color(.25,.25,.25)

func tick():
	move(direction)
