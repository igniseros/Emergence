class_name Attribute

var _value
var _name : String

func _init(name : String,value):
	set_name(name)
	set_value(value)

func get_value():
	return _value

func get_name() -> String:
	return _name

func set_value(v):
	_value = v

func set_name(name : String):
	_name = name

func create_ui_node():
	return null
