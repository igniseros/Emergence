extends PhysDot
class_name GeneratorFood2Dot

var food_nutrition = 2
#in food per turn
var production_chance = 1/100.0
var preproduce = 0

func _init():
	#set name
	name = "Food Generator"
	#set clors
	color_one = Color(1,.7,.2)
	color_two = Color(1,.5,0)
	color_three = Color(1,1,0)

func will_tick():
	return true

func tick():
	if time == 1:
		makefood(production_chance * preproduce)
	
	makefood(production_chance)
	
	

func makefood(chance):
	var box_around = PDF.box_around_self(2)
	#for each dot in a box sized 2 around self
	var i=0
	for dot in PDF.look_at_array(self, box_around):
		if randf() < chance:
			if dot is Dot and dot.name == "Dot":
				Grid.remove_dot(dot)
				var food = FoodDot.new()
				food.position = position + box_around[i]
				food.nutrition = food_nutrition
				Grid.insert_dot(food)
			if not dot is Dot:
				var food = FoodDot.new()
				food.position = position + box_around[i]
				food.nutrition = food_nutrition
				Grid.insert_dot(food)
		i+=1
