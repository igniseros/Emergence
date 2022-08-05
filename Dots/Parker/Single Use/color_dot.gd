extends Dot
class_name ColorDot

const speed = .5
const chance = .01
const bias : Color = Color(1,0,1,1)
const bias_const = 0


func will_tick():
	return true

func pre_first_tick():
	name = StringAttribute.new("Name","Color Dot")
	color_one.set_value(mix_colors(Color(randi()), bias, bias_const))
	color_two.set_value(mix_colors(Color(randi()), bias, bias_const))
	color_three.set_value(mix_colors(Color(randi()), bias, bias_const))

func tick():
	for neighbor in PDF.look_at_array(self,PDF.box_around):
		if neighbor is Dot and randf() < chance:
			color_one.set_value(mix_colors(color_one.get_value(), neighbor.color_one.get_value(), speed))
			color_two.set_value(mix_colors(color_two.get_value(), neighbor.color_two.get_value(), speed))
			color_three.set_value(mix_colors(color_three.get_value(), neighbor.color_three.get_value(), speed))

func mix_colors(c1 : Color, c2 : Color, ratio : float) -> Color:
	var v1 = Vector3(c1.r,c1.g,c1.b)
	var v2 = Vector3(c2.r,c2.g,c2.b)
	
	var out = v1.move_toward(v2,ratio)
	
	return Color(out.x,out.y,out.z)

func _on_click():
	color_one.set_value(bias)
	color_two.set_value(bias)
	color_three.set_value(bias)
