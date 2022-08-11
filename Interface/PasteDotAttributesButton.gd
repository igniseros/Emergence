extends Button

func _ready():
	UIMouse.connect("on_dot_copied", self, "_on_dot_copied")
	UIMouse.connect("good_to_paste", self, "_good_to_paste")
	UIMouse.connect("on_deselection", self, "_bad_to_paste")

func _good_to_paste():
	if UIMouse.copied_dot is Dot:
		disabled = false
	
func _bad_to_paste():
	disabled = true

func _on_PasteDotAttributesButton_pressed():
	if UIMouse.mode == UIMouse.MODE.SELECT:
		UIMouse.selected_dot.copy_attribute_values_from(UIMouse.copied_dot)
	else:
		UIMouse.queued_dot.copy_attribute_values_from(UIMouse.copied_dot)

func _on_dot_copied():
	disabled = false
