class_name Attribute

var _value
var _name : String
var _ui_read_only

signal value_changed(old_value, new_value)

func _init(name : String,value, ui_read_only = false):
	set_name(name)
	set_value(value)
	_ui_read_only = ui_read_only

func get_value():
	return _value

func get_name() -> String:
	return _name

func set_value(v):
	emit_signal("value_changed", _value, v)
	_value = v

func set_name(name : String):
	_name = name

func create_ui_node():
	return null

func _to_string():
	return str(get_value())

func get_save_value():
	return get_value()

func load_value(v):
	set_value(v)
