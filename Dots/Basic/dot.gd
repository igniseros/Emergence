class_name Dot

var name = "Dot"
var position : Vector2
var color_one = Color(1,1,1)
var color_two = Color(0,0,0)
var color_three = Color(0,0,0)
var time = 0 #should sync between everyone

func isEmpty():
	return true

func tick_wrap():
	time+=1
	tick()

func tick():
	pass
