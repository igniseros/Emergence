extends Attribute
class_name IntAttribute

var minimum = -100000
var maximum = 100000

func _init(name : String, value, mini, maxi).(name, value):
	minimum = mini
	maximum = maxi

func set_value(value):
	.set_value(int(clamp(int(value), minimum, maximum)))
	return true

func create_ui_node():
	var ui_node = load("res://Interface/IntAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node