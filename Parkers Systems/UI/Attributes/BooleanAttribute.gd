extends Attribute
class_name BooleanAttribute

func _init(name : String, value).(name, value):
	pass

func set_value(value):
	.set_value(bool(value))
	return true
	
func create_ui_node():
	var ui_node = load("res://Interface/BooleanAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node
