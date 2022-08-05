extends Panel



func _on_Panel_mouse_entered():
	UIMouse.mouse_on_grid = true
	modulate = Color(1,1,1,0)


func _on_Panel_mouse_exited():
	UIMouse.mouse_on_grid = false
	modulate = Color(1,1,1,.125)
