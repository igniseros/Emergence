extends Attribute
class_name FloatAttribute

var minimum = -1
var maximum = -1

func _init(value, mini, maxi):
	minimum = mini
	maximum = maxi
	._init(value)

func set_value(value):
	if not value is float:
		return false
	.set_value(clamp(value, minimum, maximum))
	return true

