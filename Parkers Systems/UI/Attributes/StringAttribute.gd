extends Attribute
class_name StringAttribute

func _init(name : String, value : String, ui_read_only = false).(name, value, ui_read_only):
	pass

func set_value(value):
	if not value is String:
		return false
	.set_value(value)
	return true

func create_ui_node():
	var ui_node = load("res://Interface/StringAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node
