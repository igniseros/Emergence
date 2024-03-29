extends Object
class_name Dot

var name : StringAttribute = StringAttribute.new("Name","Dot")
var age : IntAttribute = IntAttribute.new("Age", 0, 0, 2)
var position : Vector2
var color_one : ColorAttribute = ColorAttribute.new("Color 1", Color(1,1,1))
var color_two : ColorAttribute = ColorAttribute.new("Color 2", Color(0,0,0))
var color_three : ColorAttribute = ColorAttribute.new("Color 3", Color(0,0,0))
var _first_time = true
var _attributes_added = false
var _active = false
var ID : int = -1

var attributes : Array = []

func add_attributes():
	attributes.append_array([name,age, color_one, color_two, color_three])
	_attributes_added = true

func copy_attribute_values_from(dot : Dot):
	var i = 0
	for a in attributes:
		(a as Attribute).set_value(dot.attributes[i].get_value())
		i+=1

func get_color_attributes():
	return  [color_one, color_two, color_three]

func pre_first_tick():
	pass

func isEmpty():
	return true

func tick_wrap():
	age.affect_value(1)
	
	if not Grid.is_legit_dot(self):
		Grid.remove_dot(self)
	else:
		tick()

func tick():
	pass

func will_tick():
	false

func _to_string():
	return name.get_value() + " @" + str(position) + " (Active: " + str(_active) +  ")"

func _on_click():
	print(name)

func store_info(info : String):
	TheGreatConnection.store_data("DOT_DATA," + str(ID) + "," + str(position.x) + "," + str(position.y) + \
	"," + str(age.get_value()) +  "," + info)

func save_dot() -> Array:
	var value_index = TheGreatConnection.COLOR.values().find(get_script())
	var path = self.get_script().resource_path
	var save_array = [path, position]
	save_array.append_array(get_attribute_save_values())
	return save_array

func load_dot(package : Array) -> int:
	position = package[1]
	var i = 2 #the current index in the package
	for a in attributes:
		(a as Attribute).load_value(package[i])
		i += 1
	return i

func get_attribute_save_values():
	var values = []
	for a in attributes:
		values.append(a.get_save_value())
	return values

static func create_and_load(package):
	var dot = load(package[0]).new() as Dot
	dot.add_attributes()
	dot.load_dot(package)
	return dot

func is_this_class(obj):
	if obj is Object and obj.is_class(self.get_class()):
		return true
	else:
		return false

func draw_on_selected(from : Node2D):
	pass

func _on_ui_insert():
	pass

func _on_ui_delete():
	pass
	
func _on_ui_select():
	pass
