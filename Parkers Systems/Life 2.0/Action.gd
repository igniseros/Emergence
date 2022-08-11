class_name Action

var _attributes = []

func _init(attributes = []):
	_attributes = attributes

func play(dot : LifePlusBaseDot):
	pass

func get_color() -> Color:
	return Color(1,1,1)

func copy():
	return get_script().new(_attributes)

func mutate(chance : float, scale : float):
	var changes_left = chance
	while changes_left > 0:
		if randf() <= changes_left:
			random_change(scale)
		changes_left -= 1

func random_change(scale : float):
	pass

func _to_string():
	return "[Unnamed Action]"
