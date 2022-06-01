class_name Dot

var name = "Dot"
var position : Vector2
var color_one : Color = Color(1,1,1)
var color_two : Color = Color(0,0,0)
var color_three : Color = Color(0,0,0)
var time = 0 #should sync between everyone
var _first_time = true
var ID : int = -1

#returns an array of display items
func get_display() -> Array:
	return []

func pre_first_tick():
	pass

func isEmpty():
	return true

func tick_wrap():
	time+=1
	tick()

func tick():
	pass

func will_tick():
	false

func _to_string():
	return name + " @" + str(position)

func _on_click():
	pass

func store_info(info : String):
	TheGreatConnection.store_data("DOT_DATA," + str(ID) + "," + str(position.x) + "," + str(position.y) + \
	"," + str(time) +  "," + info)

func save_dot() -> Array:
	var value_index = TheGreatConnection.COLOR.values().find(get_script())
	var key = TheGreatConnection.COLOR.keys()[value_index]
	return [key, name, position]

func load_dot(package : Array) -> int:
	name = package[1]
	position = package[2]
	return 3

static func create_and_load(package):
	var dot = TheGreatConnection.COLOR[package[0]].new() as Dot
	dot.load_dot(package)
	return dot
