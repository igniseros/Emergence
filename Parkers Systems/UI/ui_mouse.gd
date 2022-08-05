extends Node2D

enum MODE {
	SELECT,
	PENCIL,
	LINE,
	CIRCLE
}

var mouse_pos : Vector2 = Vector2(0,0)

var size = 1
var mode = MODE.SELECT
var override = false
var mask = false
var insert = true

var dot_class = WallDot
var dot_color : Color = WallDot.new().color_one.get_value() - Color(0,0,0,.30)

var mouse_on_grid = false

var attribute_spawn_spot : Control
var selected_dot_position

func draw_mouse(from : Node2D):
	from.draw_circle(mouse_pos + Vector2(.5,.5), 1.25, Color(0,0,0,.1))
	if mode == MODE.SELECT:
		from.draw_circle(mouse_pos + Vector2(.5,.5), .1, Color(0,0,0,.1))
	if mode == MODE.PENCIL:
		from.draw_rect(Rect2(mouse_pos, Vector2(1,1)), dot_color)
	if mode == MODE.CIRCLE:
		from.draw_circle(mouse_pos + Vector2(.5,.5), size, dot_color)
	if mode == MODE.LINE:
		from.draw_rect(Rect2(mouse_pos - Vector2(size-1,size-1), Vector2((size-1)*2 + 1, (size-1)*2 + 1)),dot_color)
	
	if selected_dot_position != null:
		from.draw_circle(selected_dot_position + Vector2(.5,.5), 1.25, Color(0,0,0,.25))
		from.draw_circle(selected_dot_position + Vector2(.5,.5), .1, Color(0,0,0,.25))


func get_dots_at_mouse() -> Array:
	return PDF.get_at_array(get_spots_at_mouse())

func get_spots_at_mouse():
	var bucket = []
	if mode == MODE.SELECT:
		bucket.append(mouse_pos)
	if mode == MODE.PENCIL:
		bucket.append(mouse_pos)
	if mode == MODE.CIRCLE:
		var possiblespots2look = PDF.box_around_self(size-1)
		possiblespots2look.append(Vector2(0,0))
		for spot in possiblespots2look:
			spot += mouse_pos
			if mouse_pos.distance_to(spot) <= size:
				bucket.append(spot)
	if mode == MODE.LINE:
		var spots2look = PDF.box_around_self(size-1)
		spots2look.append(Vector2(0,0))
		for spot in spots2look:
			spot += mouse_pos
			bucket.append(spot)
	return bucket

func _process(delta):
	if Input.is_action_pressed("left_mouse") and mouse_on_grid:
		if mode == MODE.SELECT:
				select()
		elif insert:
			insert()
		else:
			delete()
	
	if Input.is_action_pressed("right_mouse") and mouse_on_grid:
		deselect()

func deselect():
	clear_display()
	selected_dot_position = null

func select():
	var dots = get_dots_at_mouse()
	if dots[0] is Dot:
		selected_dot_position = dots[0].position
		display_attributes(dots[0])

func insert():
	for spot in get_spots_at_mouse():
		var dotatspot = Grid.get_at(spot)
		if override:
			if dotatspot is Dot:
				Grid.remove_dot(dotatspot)
			var babydot = dot_class.new()
			babydot.position = spot
			Grid.insert_dot(babydot)
		else:
			if not dotatspot is PhysDot:
				if dotatspot is Dot:
					Grid.remove_dot(dotatspot)
				var babydot = dot_class.new()
				babydot.position = spot
				Grid.insert_dot(babydot)

func delete():
	for spot in get_spots_at_mouse():
		var dotatspot = Grid.get_at(spot)
		if (dotatspot is Dot and not mask) or dotatspot is dot_class:
			Grid.remove_dot(dotatspot)

func set_attribute_spawn_spot(ss):
	attribute_spawn_spot = ss

func clear_display():
	for c in attribute_spawn_spot.get_children():
		if c is Node:
			c = c as Node
			attribute_spawn_spot.remove_child(c)
			c.queue_free()

func display_attributes(dot : Dot):
	clear_display()
	for a in dot.attributes:
		var ui_node : Control = a.create_ui_node()
		if ui_node != null:
			attribute_spawn_spot.add_child(ui_node)
	
