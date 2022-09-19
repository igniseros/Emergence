extends Action
class_name DirectionalAction

var direction = Vector2(0,0)

func _init(attributes = []).(attributes):
	direction = PDF.rand_direction_not_zero()

func random_change(scale):
	direction = direction.rotated(rand_range(-scale,scale))

func _to_string():
	return "[Directional Action]"

func get_save_value():
	return .get_save_value() + "~" + str(direction.x) + "~" + str(direction.y)
	
func load_value(v : String):
	var action_data = v.split("~")
	direction = Vector2(float(action_data[1]), float(action_data[2]))
