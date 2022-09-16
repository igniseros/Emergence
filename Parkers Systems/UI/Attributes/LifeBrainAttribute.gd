extends MutableAttribute
class_name LifeBrainAttribute

var mutation_scale = 1
var chance_for_new_brain = .2

func _init(name : String, value : LifeBrain, mscale = 1, cfnb = .2).(name, value):
	mutation_scale = mscale
	chance_for_new_brain = cfnb

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
	if randf() < chance_for_new_brain:
		var size = get_value().weight_matrix.size()
		set_value(LifeBrain.new(size[1], size[0]))
	else:
		(get_value() as LifeBrain).mutate(mutation_scale * scale)

func copy():
	var brain = LifeBrain.new(null,null,self.get_value())
	var copy = get_script().new(_name, brain, mutation_scale)
	return copy

func get_save_value():
	return (get_value() as LifeBrain).get_save_string()

func load_value(v):
	set_value(Utils.life_brain_from_save_string(v))
