extends PushableDot
class_name LifePlusBaseDot

#constants
const LARGE_NUMBER = 1000000000
const ALMOST_ZERO = 0.0000001
const ALMOST_ONE = .999999

#the basics
var energy : FloatAttribute = FloatAttribute.new("Energy", 0)
var alive : BooleanAttribute = BooleanAttribute.new("Alive", true)

#mutations
var mutable_attributes = []
var mutation_chance : MutableFloatAttribute = MutableFloatAttribute.new("Mutation Chance", 2, ALMOST_ZERO, 15)
var mutation_scale : MutableFloatAttribute = MutableFloatAttribute.new("Mutation Scale", 2, ALMOST_ZERO, 10)

#children
var parent : LifePlusBaseDot
var children = []
var is_child = false

signal died(who_died)

func _init(_is_child = false, _parent = null):
	name.set_value("Life Plus Base")
	#set colors
	color_one.set_value(Color(0,1,0))
	color_two.set_value(Color(0,1,0))
	color_three.set_value(Color(0,1,0))
	is_child = _is_child
	parent = _parent
	if is_child:
		parent.connect("died", self, "_on_parent_died")
	#set up
	calibrate()

func will_tick():
	return true

func calibrate():
	add_mutable_attributes()

#add attributes
func add_attributes():
	.add_attributes()
	attributes.append_array([alive,energy])
	attributes.append_array(mutable_attributes)

#define what attributes will mutate
func add_mutable_attributes():
	mutable_attributes = [mutation_chance, mutation_scale]

#reproduce
func reproduce(child_energy_ratio : float = .5):
	#randomize the list
	var spots_to_check = Utils.shuffleList(PDF.box_around)
	
	#for each dot in a cirlce around this dot
	for spot in spots_to_check:
		if not Grid.is_legit_dot(PDF.look_at(self, spot)):
			use_energy(energy.get_value() * child_energy_ratio)
			var child = assemble_child(energy.get_value() * child_energy_ratio) as LifePlusBaseDot
			child.mutate()
			child.position = position + spot
			children.append(child)
			Grid.insert_dot(child)
			return true
		return false

#creates a child
func assemble_child(child_energy) -> LifePlusBaseDot:
	var child = get_script().new(true, self)
	child.add_attributes()
	child.copy_attribute_values_from(self)
	child.energy.set_value(child_energy)
	child.connect("died", self, "_on_child_died")
	
	var heatindex = child.mutation_chance.get_value() * abs(child.mutation_scale.get_value()-1)
	heatindex /= 2.0
	child.color_two.set_value(Color(heatindex, 0, 0))
	child.color_three.set_value(Color(heatindex, 0,0))
	
	return child

func mutate():
	for m in mutable_attributes:
		m = m as MutableAttribute
		m.mutate(mutation_chance.get_value(), mutation_scale.get_value())

func use_energy(amount : float):
	energy.set_value(energy.get_value() - amount)
	if energy.get_value() <= 0:
		die()

func die():
	alive.set_value(false)
	Grid.remove_dot(self)
	if energy.get_value() > 0:
		var newFood = FoodDot.new(energy.get_value())
		newFood.position = position
		Grid.insert_dot(newFood)
	emit_signal("died",self)

func life_tick():
	pass

func tick():
	if not alive.get_value():
		die()
	life_tick()

func draw_children(from : Node2D, alpha : float, depth_left : int):
	if depth_left == 0: return
	for child in children:
		if child.alive.get_value():
				from.draw_line(position + Vector2(.5,.5), child.position + Vector2(.5,.5), Color(1,0,.8,alpha))
				from.draw_circle(child.position + Vector2(.5,.5), .1, Color(1,0,.4,alpha))
				from.draw_rect(Rect2(child.position, Vector2(1,1)), Color(.5,.5,0,alpha/1.25), false)
				child.draw_children(from, alpha * alpha, depth_left - 1)

func draw_parents(from : Node2D, alpha : float, depth_left : int):
	if depth_left == 0: return
	if is_child and parent != null and parent.alive.get_value():
			from.draw_line(position + Vector2(.5,.5), parent.position + Vector2(.5,.5), Color(.8,0,1,alpha))
			from.draw_circle(parent.position + Vector2(.5,.5), .1, Color(.4,0,1,alpha))
			from.draw_rect(Rect2(parent.position, Vector2(1,1)), Color(.5,.5,0,alpha/1.25), false)
			parent.draw_parents(from, alpha * alpha, depth_left - 1)

func draw_on_selected(from : Node2D):
	.draw_on_selected(from)
	
	#draw dot on self
	from.draw_circle(position + Vector2(.5,.5), .1, Color(1,1,0))
	#draws lines to children and grandchildren
	draw_children(from, 0.98, 10)
	draw_parents(from, 0.98, 10)

func _on_child_died(child):
	children.erase(child.ID)

func _on_parent_died(p):
	parent = null
