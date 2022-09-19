extends MutableAttribute
class_name HabbitAttribute

var max_actions_per_habbit = 25

func _init(name : String, value = [], max_actions = 25, ui_read_only = true).(name, value, ui_read_only):
	max_actions_per_habbit = max_actions

func set_value(value):
	if not value is Array:
		return false
	.set_value(value)
	return true

func get_save_value():
	var s_string = ""
	var first = true
	for habit in get_value():
		if first:
			first = false
			s_string += habit.get_save_value()
		s_string += "|" + habit.get_save_value()
	return s_string

func load_value(v : String):
	var habits = []
	var split_v = v.split("|")
	for habit_string in split_v:
		var new_habit = Habit.new([],max_actions_per_habbit)
		new_habit.load_value(habit_string)
		habits.append(new_habit)
	set_value(habits)

func create_ui_node():
	var ui_node = load("res://Interface/StringAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node
