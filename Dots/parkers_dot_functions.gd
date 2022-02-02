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

#box_around_self
func box_around_self(size):
	var box = []
	for x in range(size*2+2):
		for y in range(size*2+2):
			if(x != 0 and y != 0):
				box.append(Vector2(x-size-1,y-size-1))
	return box
