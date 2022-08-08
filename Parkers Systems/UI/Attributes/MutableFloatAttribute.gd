extends FloatAttribute

var change_min = .5
var change_max = 2

func _init(name,value,mini,maxi,minchange = .5, maxchange = 2).(name,value,mini,maxi):
	change_min = minchange
	change_max = maxchange

func mutate(rate : float):
	var changes_left = rate
	while changes_left > 0:
		if randf() < changes_left:
			random_change()
		changes_left -= 1

func random_change():
	set_value(get_value() * rand_range(change_min,change_max))
