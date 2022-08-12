extends DirectionalAction
class_name CreateWallAction

func _init(attributes = []).(attributes):
	pass
	
func play(dot : LifePlusBaseDot):
	var dir = Utils.quantize(direction)
	if not PDF.look_at(dot, dir) is PhysDot:
		var new_wall = PushableWallDot.new()
		new_wall.position = dot.position + dir
		Grid.insert_dot(new_wall)

func get_color():
	return Color(1,.6,.2)

func _to_string():
	return "[Create Wall Action]"
