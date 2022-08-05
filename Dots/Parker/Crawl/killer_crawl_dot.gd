extends CrawlDot
class_name KillerCrawlDot

var chance = .5

func _init():
	randomize()
	#set name
	name = StringAttribute.new("Name","Killer Crawl")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(.85,0,.55))
	color_two = ColorAttribute.new("Color 1", Color(.50,0,.50))
	color_three = ColorAttribute.new("Color 1", Color(.75,0,.25))
	
	#set var
	direction =  rand_direction()

func rand_direction():
	return Vector2(ceil(rand_range(-2,1)),ceil(rand_range(-2,1)))

func tick():
	if (not move(direction)):
		direction = rand_direction()
		move(direction)
	
	var state = randf()
	
	if state < chance:
		var box_around = PDF.box_around_self(2)
		#for each dot in a box sized 2 around self
		for dot in PDF.look_at_array(self, box_around):
			if dot is LifeDot:
				dot.die()
