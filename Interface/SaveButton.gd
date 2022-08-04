extends Button

export var mustHavePathDialogue : NodePath
export var gridPathTextBox : NodePath

func _on_SaveButton_pressed():
	if TheGreatConnection.grid_has_path:
		var gptb : TextEdit = get_node(gridPathTextBox)
		var path = gptb.text
		TheGreatConnection.save_sim(path)
	else:
		var mhpd : AcceptDialog = get_node(mustHavePathDialogue)
		mhpd.popup_centered()
