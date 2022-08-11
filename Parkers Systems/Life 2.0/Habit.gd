class_name Habit

var actions : Array = []
var max_length : int

func _init(action_list : Array, maxlength : int = -1):
	actions = action_list
	max_length = maxlength

func execute(dot : LifePlusBaseDot):
	for i in range(actions.size()):
		if(not dot.alive.get_value()): break
		var a = actions[i] as Action
		a.play(dot)

func mutate(chance, scale, allowed_actions : Array):
	_mutate_action_list(chance, allowed_actions)
	_mutate_actions(chance, scale)
	
func _mutate_actions(chance, scale):
	for a in actions:
		a.mutate(chance,scale)

func _mutate_action_list(chance, allowed_actions : Array):
	#random chance
	var i = randf()
	#if passes
	if i < chance: i=1 #add random amount
	#chance just means more edits
	while i >= 1:
		i-=1
		var choice = floor(rand_range(0,4))
		var insert_spot = floor(rand_range(0,actions.size()))
		#choice one is insert random action
		if choice <= 0:
			if actions.size() == max_length: #don't insert if we at max length
				i+=1
			else:
				actions.append(allowed_actions[floor(rand_range(0,allowed_actions.size()))].new())
		#remove random add random
		if choice == 1:
			actions.remove(insert_spot)
			actions.insert(insert_spot,allowed_actions[floor(rand_range(0,allowed_actions.size()))].new())
		#random remove
		if choice >= 3 and actions.size() > 1:
			actions.remove(insert_spot)

func copy():
	var new_actions = []
	for a in actions:
		new_actions.append(a.copy())
	return get_script().new(new_actions, max_length)

func get_color() -> Color:
	var c = Color(0,0,0,0)
	
	for a in actions:
		c += a.get_color()  * (1.0 / float(actions.size()))
	
	return c

func _to_string():
	return str(actions)
