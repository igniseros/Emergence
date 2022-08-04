extends Button

export var file_dialogue : NodePath
export var gridPathTextBox : NodePath


func _ready():
	var fd = get_node(file_dialogue) as FileDialog
	fd.connect("file_selected", self, "_file_selected")

func _file_selected(path):
	var gptb : TextEdit = get_node(gridPathTextBox)
	gptb.text = path
	TheGreatConnection.save_sim(path)
	TheGreatConnection.grid_has_path = true


func _on_SaveAsButton_pressed():
	var fd = get_node(file_dialogue) as FileDialog
	fd.popup()
