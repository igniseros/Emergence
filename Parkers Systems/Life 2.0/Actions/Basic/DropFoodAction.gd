extends DirectionalAction
class_name DropFoodAction

var nutrition_amount = 5

func _init(_attributes = []):
	direction = PDF.rand_direction_not_zero()

func random_change(scale : float):
	.random_change(scale)
	
	var change = rand_range(1.0 / scale, scale)
	while change == 0: change = rand_range(1.0 / scale, scale)
	nutrition_amount *= change

func play(dot : LifePlusBaseDot):
	var new_pos = dot.position + Utils.quantize(direction)
	var new_food = FoodDot.new(nutrition_amount)
	new_food.position = new_pos
	if not Grid.is_legit_dot(Grid.get_at(new_pos)):
		dot.use_energy(1.1 * nutrition_amount)
		Grid.insert_dot(new_food)

func get_color():
	return Color(0,0,0)
