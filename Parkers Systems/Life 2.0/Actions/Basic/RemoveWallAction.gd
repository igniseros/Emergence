extends Action
class_name RemoveWallAction

func _init(attributes = []).(attributes):
	pass
	
func play(dot : LifePlusBaseDot):
	for m in Utils.shuffleList(PDF.look_at_array(dot, PDF.box_around)):
		dot.use_energy(.1)
		if dot.alive.get_value():
			if m is PushableWallDot:
				dot.use_energy(10)
				Grid.remove_dot(m)
				return

func get_color():
	return Color(.2,.6,1)

func _to_string():
	return "[Remove Wall Action]"
