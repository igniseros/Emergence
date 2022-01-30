extends PhysDot
class_name CrawlDot

var direction : Vector2

func _init():
	randomize()
	#set name
	name = "Crawl"
	#set clors
	color_one = Color(.75,0,.75)
	color_two = Color(.50,0,.50)
	color_three = Color(.75,0,.25)
	
	#set var
	direction =  rand_direction()

func rand_direction():
	return Vector2(ceil(rand_range(-2,1)),ceil(rand_range(-2,1)))

func tick():
	if (not move(direction)):
		direction = rand_direction()
		move(direction)
