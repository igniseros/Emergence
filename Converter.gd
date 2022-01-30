extends Node2D

func do_the_thing(image : Image):
	print("converting")
	var bag = []
	image.lock()
	var size = image.get_size()
#	print(data)
	for x in range(size.x):
		for y in range(size.y):
			var pixel_color = image.get_pixel(x,y)
			if TheGreatConnection.COLOR.has(pixel_color):
				var dot = TheGreatConnection.COLOR.get(pixel_color).new()
				dot.position = Vector2(x,y)
				bag.append(dot)
	print(str(len(bag)) + " dots found")
	return bag
