extends Attribute
class_name StringAttribute

func set_value(value):
	if not value is String:
		return false
	.set_value(value)
	return true
