extends PhysDot
class_name WallDot


func _init():
	#set name
	name = StringAttribute.new("Name","Wall")
	#set clors
	color_one = ColorAttribute.new("Color 1", Color(.75,.75,.75))
	color_two = ColorAttribute.new("Color 2", Color(.50,.50,.50))
	color_three = ColorAttribute.new("Color 3", Color(.25,.25,.25))
