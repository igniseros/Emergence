extends PushableBaseDot
class_name PushableDot

func recieve_push(direction : Vector2, strength_left : int):
	var next_in_line = PDF.look_at(self, direction)
	
	#if we run out of strength or if the next dot is an unpushable dot
	if strength_left < 0 or not check_pushablility(next_in_line):
		#abort and return false
		return false
	
	else: #if we have strength and can push the next dot
		if next_in_line is PushableBaseDot: #try to
			if next_in_line.recieve_push(direction, strength_left - 1): #if all works out
				move(direction) #move
				return true
		else: #if there is no next dot
			move(direction) #move
			return true

func try_to_push(dot : Dot, direction : Vector2, strength : int):
	if dot is PushableBaseDot and dot.is_pushable():
		return dot.recieve_push(direction, strength)
	
	return false

func check_pushablility(possible_dot):
	var pushable = false
	
	if possible_dot  is PushableBaseDot and possible_dot.is_pushable():
		pushable = true
	elif possible_dot is int or possible_dot == null:
		pushable = true
	
	return pushable
