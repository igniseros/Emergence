extends Action

var direction = Vector2(0,0)

func _init(attributes = []).(attributes):
	direction = PDF.rand_direction_not_zero()
	

func play(dot : LifePlusBaseDot):
	if dot.move(Utils.shuffleList(PDF.box_around)[0]) : dot.use_energy(1)

func get_color():
	return Color(0,0,1)

func random_change(scale):
	direction = direction.rotated(rand_range(-scale,scale))

func _to_string():
	return "[Specific Walk Action]"
