extends DirectionalAction
class_name SpecificWalkAction

func _init(attributes = []).(attributes):
	pass
	
func play(dot : LifePlusBaseDot):
	if dot.move(Utils.quantize(direction)) : dot.use_energy(1)
	else: dot.use_energy(.5)

func get_color():
	return Color(0,.5,1)

func _to_string():
	return "[Specific Walk Action]"
