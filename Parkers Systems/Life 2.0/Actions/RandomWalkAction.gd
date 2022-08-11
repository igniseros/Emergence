extends Action
class_name RandomWalkAction

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	if dot.move(Utils.shuffleList(PDF.box_around)[0]) : dot.use_energy(1)

func get_color():
	return Color(0,0,1)

func _to_string():
	return "[Random Walk Action]"
