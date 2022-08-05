extends Control

var attribute : StringAttribute
var height = 27

func set_attribute(a : StringAttribute):
	attribute = a
	$LineEdit.text = a.get_value()
	$Label.text = a.get_name()




func _on_LineEdit_text_changed(new_text):
	attribute.set_value(new_text)


func _on_LineEdit_text_entered(new_text):
	$LineEdit.hide()
	$LineEdit.visible = true
