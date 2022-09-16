extends PushableDot
class_name DirtDot

var minerals : FloatAttribute = FloatAttribute.new("Minerals", 0, 0)
var mineral_change : FloatAttribute = FloatAttribute.new("Mineral change", 1)
var mineral_share : FloatAttribute = FloatAttribute.new("Mineral sharing", .25, 0, 1)
var share_chance : FloatAttribute = FloatAttribute.new("Share chance", .005, 0, 1)
var dirt_color : ColorAttribute = ColorAttribute.new("Dirt color", Color(.6,.4,.2))
var color_scale : FloatAttribute = FloatAttribute.new("Color scale", 1.0/10.0, 0)

func _init():
	name.set_value("Dirt")
	color_one.set_value(dirt_color)
	color_two.set_value(dirt_color)
	color_three.set_value(dirt_color)

func will_tick():
	return true

func add_attributes():
	.add_attributes()
	attributes.append_array([minerals,mineral_change,mineral_share, share_chance, dirt_color,color_scale])

func tick():
	minerals.set_value(minerals.get_value() + (mineral_change.get_value() * randf()))
	if randf() < share_chance.get_value():
		var random_choice = floor(randf() * 8)
		var random_look_dot = PDF.look_at(self, PDF.box_around[random_choice])
		if random_look_dot is Dot and random_look_dot.name.get_value() == name.get_value():
			var big_dot = self
			var small_dot = random_look_dot
			if minerals.get_value() < random_look_dot.minerals.get_value():
				big_dot = random_look_dot
				small_dot = self
			var gift = big_dot.minerals.get_value() * mineral_share.get_value()
			small_dot.minerals.set_value(small_dot.minerals.get_value() + gift)
			big_dot.minerals.set_value(big_dot.minerals.get_value() - gift)
	var c = dirt_color.get_value() * log(minerals.get_value()) * color_scale.get_value()
	c.a = 1
	color_one.set_value(c)

func transfer_minerals(dot : LifePlusBaseDot):
	if minerals.get_value() > 1:
		dot.gain_minerals(1)
		minerals.affect_value(-1)
	
