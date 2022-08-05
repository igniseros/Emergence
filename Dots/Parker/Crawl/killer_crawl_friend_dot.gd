extends KillerCrawlDot
class_name KillerCrawlFriendDot

var main_direction : Vector2
var gravity = 1

func _init():
	randomize()
	#set name
	name = StringAttribute.new("Name","Killer Crawl Friend")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(.85,.4,.55))
	color_two = ColorAttribute.new("Color 1", Color(.75,0,.75))
	color_three = ColorAttribute.new("Color 1", Color(.75,0,.25))
	
	#set var
	main_direction =  Vector2(0,0)

func rand_direction():
	return Vector2(ceil(rand_range(-2,1)),ceil(rand_range(-2,1)))


func tick():
	var state = randf()
	
	if state < chance:
		var box_around = PDF.box_around_self(2)
		#for each dot in a box sized 2 around self
		for dot in PDF.look_at_array(self, box_around):
			if dot is LifeDot:
				dot.die()
	
	
	var directions_to_check = [Vector2(-1,0),Vector2(1,0),Vector2(0,1),Vector2(0,-1),
	Vector2(1,-1),Vector2(-1,-1),Vector2(1,1),Vector2(-1,1)]
	var best_d = []
	var f_thresh = 2
	for d in directions_to_check:
		var favorability = check_direction(d)
		if(favorability >= f_thresh):
			for i in range(favorability ^ gravity):
				best_d.append(d)
	if(best_d.size() > 0):
		move(best_d[floor(rand_range(0,len(best_d)))])


#checks if direction is favorable to move in
#returns favorability
func check_direction(d: Vector2):
	var in_direction = PDF.look_at_array(self, [d, d*2])
	var f = 0
	if not in_direction[0] is PhysDot : 
		f=1
		if in_direction[1] is KillerCrawlDot: f=2
	return f
