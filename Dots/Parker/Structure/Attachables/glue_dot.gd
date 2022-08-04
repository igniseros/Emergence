extends AttachableDot
class_name GlueDot

var search_area : Array
var first_time = true

func _init():
	#set name
	name = "Glue Dot"
	#set clors
	color_one = Color(1,1,1)
	color_two = Color(0,0,.50)
	color_three = Color(0,0,.25)
	
	search_area = PDF.box_around_self(2)


func tick():
	.tick()
	stick()

#stick to every dot around you
func stick():
	if first_time:
		first_time = false
		var cute_dude = PDF.look_at(self, Vector2(1,0)) 
		if cute_dude is PhysDot:
			attachments.append(cute_dude)
