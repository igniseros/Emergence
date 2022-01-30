extends Node

#looks at one position
func look_at(sender : Dot, direction : Vector2):
	return Grid.get_at(sender.position + direction)

#looks at a bunch of positions
func look_at_array(sender : Dot, directions : Array):
	var seen = []
	for d in directions:
		seen.append(Grid.get_at(sender.position + d))
	return seen
