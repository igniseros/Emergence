extends Dot

class_name PhysDot

func isEmpty():
	return false

func move( direction : Vector2 ):
	var landing_spot = position + direction
	var landing_dot = Grid.get_at(landing_spot)
	if(not landing_dot is Dot or landing_dot.isEmpty()):
		set_position(landing_spot)
		return true
	return false

func set_position( pos : Vector2):
	var replacement = Dot.new()
	replacement.position = position
	Grid.grid[position.x][position.y] = replacement
	position = pos
	Grid.grid[position.x][position.y] = self
