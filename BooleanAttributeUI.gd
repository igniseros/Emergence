extends Control

var attribute : BooleanAttribute

func set_attribute(a : BooleanAttribute):
	attribute = a
	$CheckButton.pressed = a.get_value()
	$CheckButton.disabled = a._ui_read_only
	$Label.text = a.get_name()
	a.connect("value_changed", self, "_on_value_changed")

func _on_value_changed(old_val, new_val):
	$CheckButton.pressed = new_val


func _on_CheckButton_toggled(button_pressed):
	attribute.set_value(button_pressed)
