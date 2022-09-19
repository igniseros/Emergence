extends Attribute
class_name MutableAttribute

func _init(name,value, ui_read_only = false).(name,value, ui_read_only):
	pass

func mutate(chance : float, scale : float):
	var changes_left = chance
	while changes_left > 0:
		if randf() <= changes_left:
			random_change(scale)
		changes_left -= 1

func random_change(scale : float):
	pass
