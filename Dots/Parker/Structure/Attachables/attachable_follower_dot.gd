extends AttachableDot
class_name AttachableFollowerDot

func _init():
	#set name
	name = "Attachable Follower Dot"
	#set clors
	color_one = Color(.55,.35,.25)
	color_two = Color(0,0,.50)
	color_three = Color(0,0,.25)

func pre_first_tick():
	for dot in PDF.look_at_array(self,PDF.box_around):
		if dot is AttachableDot:
			AttachableDot.attach(self,dot)
