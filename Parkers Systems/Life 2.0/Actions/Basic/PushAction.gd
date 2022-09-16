extends DirectionalAction
class_name PushAction

func _init(attributes = []).(attributes):
	pass
	

#_attributes[0] should be strength
func play(dot : LifePlusBaseDot):
	var dir = Utils.quantize(direction)
	var dot2push = PDF.look_at(dot, dir)
	if dot2push is PushableDot and dot.try_to_push(dot2push,dir,4):
		dot.use_energy(2)
	else:
		dot.use_energy(.2)

func get_color():
	return Color(.4,.4,.4)

func _to_string():
	return "[Push Action]"
