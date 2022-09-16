extends Action
class_name ChangeColorThreeAction

var color_change = Color(0,0,0)

func _init(attributes = []).(attributes):
	color_change = Color(randf(),randf(),randf())

func play(dot : LifePlusBaseDot):
	dot.use_energy(.01)
	dot.color_three.set_value(color_change)

func get_color():
	return Color(1,1,1)

func random_change(scale :float):
	color_change += Color(rand_range(-scale,scale), rand_range(-scale,scale), rand_range(-scale,scale))

func _to_string():
	return "[Change Color Three Action]"
