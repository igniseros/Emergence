extends PhysDot
class_name PushableBaseDot

var is_pushable : BooleanAttribute = BooleanAttribute.new("Pushable", true)

func add_attributes():
	.add_attributes()
	attributes.append(is_pushable)

func is_pushable():
	return is_pushable.get_value()


