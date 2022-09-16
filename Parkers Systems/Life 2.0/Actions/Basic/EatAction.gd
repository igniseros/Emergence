extends Action
class_name EatAction

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	for m in Utils.shuffleList(PDF.look_at_array(dot, PDF.box_around)):
		dot.use_energy(.1)
		if m is FoodDot:
			Grid.remove_dot(m)
			dot.use_energy(-1 * m.nutrition.get_value())
			return

func get_color():
	return Color(0,1,0)

func _to_string():
	return "[Eat Action]"
