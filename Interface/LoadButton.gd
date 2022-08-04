extends Button

export var file_dialogue : NodePath
export var gridPathTextBox : NodePath


func _ready():
	var fd = get_node(file_dialogue) as FileDialog
	fd.connect("file_selected", self, "_file_selected")

func _on_LoadButton_pressed():
	var fd = get_node(file_dialogue) as FileDialog
	fd.popup()

func _file_selected(path):
	var gptb : TextEdit = get_node(gridPathTextBox)
	
	if path.split('.')[-1] == "grid":
		gptb.text = path
		TheGreatConnection.load_sim(path)
		TheGreatConnection.grid_has_path = true
	if path.split('.')[-1] == "png":
		gptb.text = "no-path"
		var image : Texture = load(path)
		Grid.load_image(image)
		TheGreatConnection.grid_has_path = false
	Grid.grid_node.update()
