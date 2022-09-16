extends MutableAttribute
class_name MutableFloatAttribute

var minimum = -1.79769e308
var maximum = 1.79769e308

func _init(name,value,mini = -1.79769e308, maxi = 1.79769e308).(name,value):
	minimum = mini
	maximum = maxi

func set_value(value):
	.set_value(clamp(float(value), minimum, maximum))
	return true

func create_ui_node():
	var ui_node = load("res://Interface/FloatAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node

func random_change(scale : float):
	set_value(get_value() * rand_range(1.0/scale, scale))
