extends PhysDot
class_name GeneratorFood2Dot

var food_nutrition = FloatAttribute.new("Food Nutrition", 1, -100000, 100000)
#in food per turn
var production_chance = FloatAttribute.new("Production chance", 1/100.0, 0, 1)
var preproduce = IntAttribute.new("Preproduce", 0, 0, 100000)
var size = IntAttribute.new("Size", 2, 0, 100)

func _init():
	#set name
	name = StringAttribute.new("Name","Food Generator")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(1,.7,.2))
	color_two = ColorAttribute.new("Color 2", Color(1,.5,0))
	color_three = ColorAttribute.new("Color 3", Color(1,1,0))

func add_attributes():
	.add_attributes()
	attributes.append_array([food_nutrition,size,production_chance,preproduce])

func will_tick():
	return true

func tick():
	if time == 1:
		makefood(production_chance.get_value() * preproduce.get_value())
	
	makefood(production_chance.get_value())
	
	

func makefood(chance):
	var box_around = PDF.box_around_self(size.get_value())
	#for each dot in a box sized 2 around self
	var i=0
	for dot in PDF.look_at_array(self, box_around):
		if randf() < chance:
			if dot is Dot and dot.name.get_value() == "Dot":
				Grid.remove_dot(dot)
				var food = FoodDot.new()
				food.position = position + box_around[i]
				food.nutrition = food_nutrition.get_value()
				Grid.insert_dot(food)
			if not dot is Dot:
				var food = FoodDot.new()
				food.position = position + box_around[i]
				food.nutrition = food_nutrition.get_value()
				Grid.insert_dot(food)
		i+=1
