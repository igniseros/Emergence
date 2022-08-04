extends Dot
class_name ColorDot

const speed = .5
const chance = .01
const bias : Color = Color(1,0,1,1)
const bias_const = 0


func will_tick():
	return true

func pre_first_tick():
	name = "Color Dot"
	color_one = mix_colors(Color(randi()), bias, bias_const)
	color_two = mix_colors(Color(randi()), bias, bias_const)
	color_three = mix_colors(Color(randi()), bias, bias_const)

func tick():
	for neighbor in PDF.look_at_array(self,PDF.box_around):
		if neighbor is Dot and randf() < chance:
			color_one = mix_colors(color_one, neighbor.color_one, speed)
			color_two = mix_colors(color_two, neighbor.color_two, speed)
			color_three = mix_colors(color_three, neighbor.color_three, speed)

func mix_colors(c1 : Color, c2 : Color, ratio : float) -> Color:
	var v1 = Vector3(c1.r,c1.g,c1.b)
	var v2 = Vector3(c2.r,c2.g,c2.b)
	
	var out = v1.move_toward(v2,ratio)
	
	return Color(out.x,out.y,out.z)

func _on_click():
	color_one = bias
	color_two = bias
	color_three = bias