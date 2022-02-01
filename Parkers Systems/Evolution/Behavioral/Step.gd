class_name Step

var name = "step"

func _init():
	return self

func get_parameters() -> Array:
	return []

func set_parameters(x):
	pass

#plays the step, parameters must be correct amount and be floats between 0 and 1
func play(dot : LifeDot):
	pass

func get_color_mod():
	return Color(0,0,0)
