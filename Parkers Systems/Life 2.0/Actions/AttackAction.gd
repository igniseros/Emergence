extends Action
class_name AttackAction

func _init(attributes = []).(attributes):
	pass

func play(dot : LifePlusBaseDot):
	for m in Utils.shuffleList(PDF.look_at_array(dot, PDF.box_around)):
		dot.use_energy(.1)
		if m is LifePlusBaseDot:
			m.use_energy(4)
			dot.use_energy(-2.5)
			return

func get_color():
	return Color(1,0,0)

func _to_string():
	return "[Attack Action]"
