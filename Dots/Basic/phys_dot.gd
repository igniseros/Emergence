extends Dot

class_name PhysDot

func isEmpty():
	return false

func move(direction : Vector2 ):
	var landing_spot = position + direction
	if can_move_into(landing_spot):
		set_position(landing_spot)
		return true
	return false

func can_move_into(spot : Vector2):
	var ret = false
	if not Grid.good_pos(spot):
		return ret
	
	var possible_dot = Grid.get_at(spot)
	if(not possible_dot is Dot): #if not a dot
		ret = true
	else: #if a dot
		if possible_dot.isEmpty():
			ret = true
	return ret

func set_position( pos : Vector2):
	var at_spot = Grid.get_at(pos)
	if at_spot is Dot:
		Grid.remove_dot(at_spot)
		print("Replacing " + str(at_spot) + " with " + str(self))
	
	var replacement = 0
	Grid.grid[position.x][position.y] = replacement
	position = pos
	Grid.grid[position.x][position.y] = self
