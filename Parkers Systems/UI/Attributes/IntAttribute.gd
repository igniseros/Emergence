extends Attribute
class_name IntAttribute

var minimum = -1
var maximum = -1

func _init(value, mini, maxi):
	minimum = mini
	maximum = maxi
	._init(value)

func set_value(value):
	if not value is int:
		return false
	.set_value(int(clamp(value, minimum, maximum)))
	return true
