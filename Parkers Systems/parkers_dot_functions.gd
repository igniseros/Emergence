extends Node

var box_around = [Vector2(-1,0),Vector2(-1,1),Vector2(0,1),Vector2(1,1),Vector2(1,0),Vector2(1,-1),Vector2(0,-1),Vector2(-1,-1)]

#looks at one position
func look_at(sender : Dot, direction : Vector2):
	return Grid.get_at(sender.position + direction)

#looks at a bunch of positions
func look_at_array(sender : Dot, directions : Array):
	var seen = []
	for d in directions:
		seen.append(Grid.get_at(sender.position + d))
	return seen

#returns a random direction
func rand_direction():
	return Vector2(ceil(rand_range(-2,1)),ceil(rand_range(-2,1)))

func rand_direction_not_zero():
	var ret = rand_direction()
	while ret == Vector2(0,0):
		ret = rand_direction()
	return ret

#box_around_self
func box_around_self(size) -> Array:
	var box = []
	for x in range(size*2+1):
		for y in range(size*2+1):
			if not (x-size == 0 and y-size == 0):
				box.append(Vector2(x-size,y-size))
	return box

func float2dir(xf,yf) -> Vector2:
	var x = round(xf * 2) - 1
	var y = round(yf * 2) - 1 
	return Vector2(x,y)
