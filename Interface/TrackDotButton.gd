extends Button

func _ready():
	UIMouse.connect("on_selection_made", self, "_on_selection_made")
	UIMouse.connect("on_deslelection", self, "_on_deselection")

func _on_TrackDotButton_pressed():
	var dot = UIMouse.selected_dot
	if UIMouse.is_dot_tracked(dot):
		UIMouse.tracked_dots.erase(dot.ID)
		text = "Track"
	else:
		UIMouse.tracked_dots[dot.ID] = dot
		text = "Untrack"
	Grid.grid_node.update()

func _on_selection_made(dot):
	if dot is Dot:
		disabled = false
		if UIMouse.is_dot_tracked(dot):
			text = "Untrack"
		else:
			text = "Track"
	
func _on_deselection():
	disabled = true
	text = "Track"
