extends Control

var attribute : ColorAttribute
var height = 470

func set_attribute(a : ColorAttribute):
	attribute = a
	$ColorPicker.color = a.get_value()
	$Label.text = a.get_name()




func _on_ColorPicker_color_changed(color):
	attribute.set_value(color)
