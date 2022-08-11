extends SpinBox

func _ready():
	value = Grid.timer_per_tick

func _on_TimeSpinBox_value_changed(value):
		Grid.timer_per_tick = value

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var before = visible
		hide()
		visible = before
		
