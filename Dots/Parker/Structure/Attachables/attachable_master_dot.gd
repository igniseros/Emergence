extends AttachableDot
class_name AttachableMasterDot


func _init():
	#set name
	name = StringAttribute.new("Attachable Master Dot")
	#set clors
	color_one = Color(.75,.35,.25)
	color_two = Color(0,0,.50)
	color_three = Color(0,0,.25)

func tick():
	drag_move(PDF.rand_direction())
