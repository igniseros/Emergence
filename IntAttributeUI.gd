extends Control

var attribute : IntAttribute
var height = 470

func set_attribute(a : IntAttribute):
	attribute = a
	$SpinBox.value = a.get_value()
	$SpinBox.min_value = a.minimum
	$SpinBox.max_value = a.maximum
	$Label.text = a.get_name()





func _on_SpinBox_value_changed(value):
	attribute.set_value(value)
