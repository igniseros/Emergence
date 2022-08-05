extends Attribute
class_name FloatAttribute

var minimum = -100000
var maximum = 100000

func _init(name : String, value, mini, maxi).(name, value):
	minimum = mini
	maximum = maxi

func set_value(value):
	.set_value(clamp(float(value), minimum, maximum))
	return true

func create_ui_node():
	var ui_node = load("res://Interface/FloatAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node
