extends CrawlDot
class_name BugDot

func _init():
	#set name
	name = "Bug"
	#set in-game colors
	color_one = Color8(105, 52, 52)
	color_two = Color(.50,.50,.50)
	color_three = Color(.25,.25,.25)

func tick():
	# TODO: if touches pink dot, it hops on (erase bug and change color and maybe type of pink). If touches other bug make baby bug.
	if (not move(direction)):
		direction = rand_direction()
		color_one = Color8(67, 164, 57)
	else:
		color_one = Color8(105, 52, 52)
