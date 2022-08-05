extends PushableDot
class_name AttachableDot

#array of attachments
var attachments : Array = []

func _init():
	#set name
	name = StringAttribute.new("Name","Attachable Dot")
	#set clors
	color_one = Color(0,0,.75)
	color_two = Color(0,0,.50)
	color_three = Color(0,0,.25)

func will_tick():
	return true

func tick():
	pass

func get_attempts():
	return 5

#return if no adjustment is required
func is_attached():
	for a in attachments:
		if not is_attachment_correct(a):
			return false
	return true

func is_attachment_correct(a):
	var found = false
	for dot in PDF.look_at_array(self, PDF.box_around):
		if dot is Dot and dot == a : 
			found = true
	return found

#assumes not attached properly
#check all dots in attachments
#chooses best one
#make relations correct
#continues to other dots
func fix_attachment(already_fixed : Array):
	if already_fixed.has(self) : return
	var chosen_one = choose_best_attachment(already_fixed)
	var position_diff : Vector2 = chosen_one.position - position
	var change : Vector2 = position_diff / position_diff.abs()
	if is_nan(change.x): 
		change.x = 0
	if is_nan(change.y) :
		change.y = 0
	#if you cant move where you need to, move randomly
	var tries = 0
	move(change)
	#continues to other dots
	already_fixed.append(self)
	for a in attachments:
		if not is_attachment_correct(a):
			a.fix_attachment(already_fixed)

#the best attachment to move towards is the closest one more than 1 block away
func choose_best_attachment(already_fixed):
	#default to 0
	var best = already_fixed[0] as Dot
	#for each attachment
	for a in already_fixed:
		a = a as Dot
		#if a is further than 1 block away and either the best choice is less than 1 or further away than the current block
		if a.position.distance_to(position) >= 2 and \
		(best.position.distance_to(position) < 2 or \
		best.position.distance_to(position) > a.position.distance_to(position)):
			best = a
	return best

func drag_move(dist : Vector2):
	var ret = move(dist)
	for a in attachments:
		if not is_attachment_correct(a):
			a.fix_attachment([self])
	return ret

static func attach(m : AttachableDot, f : AttachableDot):

	if not m.attachments.has(f) : m.attachments.append(f)
	if not f.attachments.has(m) : f.attachments.append(m)

static func separate(m : AttachableDot, f : AttachableDot):
	m.attachments.remove(m.attachments.find(f))
	f.attachments.remove(f.attachments.find(m))
