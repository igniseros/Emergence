extends Control

var attribute : ColorAttribute
var height = 470

func set_attribute(a : ColorAttribute):
	attribute = a
	$ColorPickerButton.color = a.get_value()
	$ColorPickerButton.disabled = a._ui_read_only
	$Label.text = a.get_name()
	a.connect("value_changed", self, "_on_value_changed")

func _on_value_changed(old_val, new_val):
	$ColorPickerButton.color = new_val

func _on_ColorPickerButton_color_changed(color):
		attribute.set_value(color)
