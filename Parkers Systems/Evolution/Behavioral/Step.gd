class_name Step

func get_name():
	return "Step"

func _init(p = []):
	if(p.size() > 0):
		set_parameters(p)
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

func duplicate():
	var ret = self.get_script().new()
	var params = []
	for p in get_parameters():
		params.append(p)
	ret.set_parameters(params)
	return ret
