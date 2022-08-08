extends PushableDot
class_name PushableCrawlDot

var direction : Vector2
var strength : IntAttribute = IntAttribute.new("Strength", 10, 0, 1000)

func _init():
	randomize()
	#set name
	name = StringAttribute.new("Name","Pushable Crawl")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(.45,0,.75))
	color_two = ColorAttribute.new("Color 2", Color(.30,0,.50))
	color_three = ColorAttribute.new("Color 3", Color(.45,0,.65))
	
	#set var
	direction =  rand_direction()

func add_attributes():
	.add_attributes()
	attributes.append_array([strength])

func rand_direction():
	return Vector2(ceil(rand_range(-2,1)),ceil(rand_range(-2,1)))

func tick():
	if (not move(direction)):
		if not try_to_push(PDF.look_at(self, direction), direction, strength.get_value()):
			direction = rand_direction()
		move(direction)

func will_tick():
	return true
