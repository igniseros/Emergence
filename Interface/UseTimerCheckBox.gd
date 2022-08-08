extends CheckBox

export var label : NodePath
export var time : NodePath
export var color_helper : NodePath

func _ready():
	pressed = Grid.using_timer

func _on_UseTimerCheckBox_toggled(button_pressed):
	var l : Label = get_node(label)
	var t : SpinBox = get_node(time)
	var c : Panel = get_node(color_helper)
	l.visible = button_pressed
	t.visible = button_pressed
	c.visible = button_pressed
	Grid.using_timer = button_pressed
