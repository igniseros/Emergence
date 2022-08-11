extends Button


func _ready():
	UIMouse.connect("on_selection_made", self, "_on_selection_made")
	UIMouse.connect("good_to_paste", self, "_good_to_paste")
	UIMouse.connect("on_deslelection", self, "_on_deselection")

func _on_CopyDotAttributesButton_pressed():
	if UIMouse.mode == UIMouse.MODE.SELECT:
		UIMouse.copied_dot = UIMouse.selected_dot
	else:
		UIMouse.copied_dot = UIMouse.queued_dot
	
	UIMouse.emit_signal("on_dot_copied")

func _on_selection_made(dot):
	if dot is Dot:
		disabled = false
	
func _on_deselection():
	disabled = true

func _good_to_paste():
	disabled = false
