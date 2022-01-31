extends PhysDot
class_name KillerWallDot

var chance = .2

func _init():
	#set name
	name = "Killer Wall"
	#set clors
	color_one = Color(1,0,0)
	color_two = Color(1,.5,0)
	color_three = Color(1,1,0)

func tick():
	var state = randf()
	
	if state < chance:
		var box_around = PDF.box_around_self(2)
		#for each dot in a box sized 2 around self
		for dot in PDF.look_at_array(self, box_around):
			if dot is LifeDot:
				dot.die()
