extends Control

var attribute : FloatAttribute
var height = 470

func set_attribute(a : FloatAttribute):
	print(a.get_value())
	attribute = a
	$SpinBox.value = a.get_value()
	$SpinBox.min_value = a.minimum
	$SpinBox.max_value = a.maximum
	$Label.text = a.get_name()





func _on_SpinBox_value_changed(value):
	attribute.set_value(value)


func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept"):
			$SpinBox.hide()
			$SpinBox.visible = true
