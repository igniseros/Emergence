extends Attribute
class_name ColorAttribute

func _init(name : String, value).(name, value):
	pass

func set_value(value):
	if not value is Color:
		return false
	.set_value(value)
	return true
	
func create_ui_node():
	var ui_node = load("res://Interface/ColorAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node
