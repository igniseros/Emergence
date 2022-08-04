extends CheckBox

export var label : NodePath
export var time : NodePath

func _ready():
	pressed = Grid.using_timer

func _on_UseTimerCheckBox_toggled(button_pressed):
	var l : Label = get_node(label)
	var t : SpinBox = get_node(time)
	l.visible = button_pressed
	t.visible = button_pressed
	Grid.using_timer = button_pressed
