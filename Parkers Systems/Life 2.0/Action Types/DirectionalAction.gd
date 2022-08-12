extends Action
class_name DirectionalAction

var direction = Vector2(0,0)

func _init(attributes = []).(attributes):
	direction = PDF.rand_direction_not_zero()

func random_change(scale):
	direction = direction.rotated(rand_range(-scale,scale))

func _to_string():
	return "[Directional Action]"
