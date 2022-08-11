extends MutableAttribute
class_name LifeBrainAttribute

var mutation_scale = 1

func _init(name : String, value : LifeBrain, mscale = 1).(name, value):
	mutation_scale = mscale

func get_value():
	return _value
	
func get_habit_index(inputs : Vector):
	return (get_value() as LifeBrain).condensed_think(inputs)

func set_value(value):
	if not value is LifeBrain:
		return false
	.set_value(value)
	return true

func create_ui_node():
	var ui_node = load("res://Interface/LifeBrainAttributeUI.tscn").instance()
	ui_node.set_attribute(self)
	return ui_node

func random_change(scale):
	(get_value() as LifeBrain).mutate(mutation_scale * scale)

func copy():
	var brain = LifeBrain.new(null,null,self.get_value())
	var copy = get_script().new(_name, brain, mutation_scale)
	return copy
