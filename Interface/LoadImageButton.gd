extends Button

export var file_dialogue : NodePath
export var gridPathTextBox : NodePath


func _ready():
	var fd = get_node(file_dialogue) as FileDialog
	fd.connect("file_selected", self, "_file_selected")

func _file_selected(path : String):
	


func _on_LoadImageButton_pressed():
	var fd = get_node(file_dialogue) as FileDialog
	fd.popup()
