extends CheckBox



func _on_FancyDrawCheckBox_toggled(button_pressed):
	Grid.grid_node.cheap_draw = not button_pressed
	Grid.grid_node.update()
