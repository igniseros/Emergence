extends Control

var attribute : Attribute
var height = 470

func set_attribute(a : Attribute):
	attribute = a
	$SpinBox.min_value = a.minimum
	$SpinBox.max_value = a.maximum
	$SpinBox.editable = not a._ui_read_only
	$SpinBox.value = a.get_value()
	$Label.text = a.get_name()
	a.connect("value_changed", self, "_on_value_changed")

func _on_value_changed(old_val, new_val):
	$SpinBox.value = new_val

func _on_SpinBox_value_changed(value):
	attribute.set_value(value)

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept"):
			$SpinBox.hide()
			$SpinBox.visible = true
