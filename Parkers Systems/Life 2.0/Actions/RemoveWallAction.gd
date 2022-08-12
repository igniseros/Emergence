extends DirectionalAction
class_name RemoveWallAction

func _init(attributes = []).(attributes):
	pass
	
func play(dot : LifePlusBaseDot):
	var dir = Utils.quantize(direction)
	if PDF.look_at(dot, dir) is PushableWallDot:
		Grid.remove_dot(PDF.look_at(dot, dir))

func get_color():
	return Color(.2,.6,1)

func _to_string():
	return "[Remove Wall Action]"
