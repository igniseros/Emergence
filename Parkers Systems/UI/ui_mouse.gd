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

var line_time = false
var drawing_line = false
var line_start : Vector2
var line_end : Vector2
var warning_area_thresh = 2000
var limit_area_thresh = 20000

var dot_class = WallDot
var dot_color : Color = WallDot.new().color_one.get_value() - Color(0,0,0,.30)
var queued_dot : Dot = dot_class.new()

var mouse_on_grid = false

var attribute_spawn_spot : Control
var selected_dot_position

func _ready():
	queued_dot.add_attributes()

func switch_to_select():
	if mode != MODE.SELECT:
		deselect()
	mode = MODE.SELECT

func switch_to_line():
	if mode == MODE.SELECT:
		deselect()
		display_attributes(queued_dot)
	mode = MODE.LINE

func switch_to_circle():
	if mode == MODE.SELECT:
		deselect()
		display_attributes(queued_dot)
	mode = MODE.CIRCLE

func switch_to_pencil():
	if mode == MODE.SELECT:
		deselect()
		display_attributes(queued_dot)
	mode = MODE.PENCIL


func draw_mouse(from : Node2D):
	from.draw_circle(mouse_pos + Vector2(.5,.5), 1, Color(0,0,0,.05))
	if mode == MODE.SELECT:
		from.draw_circle(mouse_pos + Vector2(.5,.5), .1, Color(0,0,0,.1))
	if mode == MODE.PENCIL:
		from.draw_rect(Rect2(mouse_pos, Vector2(1,1)), dot_color)
	if mode == MODE.CIRCLE:
		from.draw_circle(mouse_pos + Vector2(0.5,0.5), size*6, Color(1,1,1,.02))
		from.draw_circle(mouse_pos + Vector2(.5,.5), size, dot_color)
	if mode == MODE.LINE:
		from.draw_circle(mouse_pos + Vector2(0.5,0.5), size*6, Color(1,1,1,.02))
		from.draw_rect(Rect2(mouse_pos - Vector2(size-1,size-1), Vector2((size-1)*2 + 1, (size-1)*2 + 1)),dot_color)
	if line_time and drawing_line and mode != MODE.SELECT:
		var line_width = size*2 if mode != MODE.PENCIL else 2
		var line_color = dot_color
		if line_start.distance_to(line_end) * size * 2 > warning_area_thresh:
			line_width *= .95
			line_color = Color(1,1,0, .8)
		if line_start.distance_to(line_end) * size * 2 > limit_area_thresh:
			line_width *= .1
			line_color = Color(1,0,0)
		from.draw_line(line_start  + Vector2(.5,.5),line_end  + Vector2(.5,.5), line_color, line_width)
		from.draw_line(line_start  + Vector2(.5,.5),line_end  + Vector2(.5,.5), Color(0,0,0,1), 1)
		from.draw_circle(line_start + Vector2(.5,.5), size, Color(0,0,0,.1))
		from.draw_circle(line_start + Vector2(.5,.5), 1, Color(0,0,0,1))
		from.draw_circle(line_end + Vector2(.5,.5), size, Color(0,0,0,.1))
	
	if selected_dot_position != null:
		from.draw_circle(selected_dot_position + Vector2(.5,.5), 1.25, Color(0,0,0,.25))
		from.draw_circle(selected_dot_position + Vector2(.5,.5), .1, Color(0,0,0,.25))

func change_queued_dot(dot : Dot):
	queued_dot = dot
	display_attributes(queued_dot)

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
		elif not line_time:
			if insert:
				insert()
			else:
				delete()
		else:
			line_end = mouse_pos
	
	if Input.is_action_pressed("right_mouse") and mouse_on_grid:
		if mode == MODE.SELECT:
			deselect()

func _input(event):
	if line_time and mouse_on_grid:
		if event is InputEventMouseButton:
			if event.is_action_pressed("left_mouse"):
				line_start = mouse_pos
				drawing_line = true
			if event.is_action_released("left_mouse"):
				if line_time:
					line_end = mouse_pos
					drawing_line = false
					make_line()

var size_scale = .4
func make_line():
	print(line_start.distance_to(line_end))
	print(size)
	print(line_start.distance_to(line_end) * size * 2)
	if line_start.distance_to(line_end) * size * 2 > limit_area_thresh:
		return
	var direction = line_start.direction_to(line_end)
	var draw_pos = line_start

	while draw_pos.distance_to(line_end) > .5 * size:
		mouse_pos = quantize(draw_pos) + Vector2(0,1)
		if insert: insert()
		else: delete()
		draw_pos += direction * size * size_scale
		print(draw_pos.distance_to(line_end))
	
	mouse_pos = quantize(Grid.grid_node.get_local_mouse_position())
	if insert: insert()
	else: delete()


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
			_ui_insert_at(spot)
		else:
			if not dotatspot is PhysDot:
				if dotatspot is Dot:
					Grid.remove_dot(dotatspot)
				_ui_insert_at(spot)

func _ui_insert_at(spot):
	var babydot = dot_class.new()
	babydot.position = spot
	babydot.add_attributes()
	babydot.copy_attribute_values_from(queued_dot)
	Grid.insert_dot(babydot)

func delete():
	for spot in get_spots_at_mouse():
		var dotatspot = Grid.get_at(spot)
		if (dotatspot is Dot and not mask) or dotatspot is dot_class:
			Grid.remove_dot(dotatspot)

func set_attribute_spawn_spot(ss):
	attribute_spawn_spot = ss

func quantize(pos : Vector2 ) -> Vector2:
	return pos.ceil() + Vector2(-1,-1)

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
	
