extends Control

var attribute : Attribute
var height = 27

func set_attribute(a : Attribute):
	attribute = a
	$LineEdit.text = str(a.get_value())
	$LineEdit.editable = not a._ui_read_only
	$Label.text = a.get_name()
	a.connect("value_changed", self, "_on_value_changed")

func _on_value_changed(old_val, new_val):
	$LineEdit.text = new_val

func _on_LineEdit_text_entered(new_text):
	attribute.set_value(new_text)
	$LineEdit.hide()
	$LineEdit.visible = true
