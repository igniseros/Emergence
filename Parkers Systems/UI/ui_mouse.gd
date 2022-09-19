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

var selected_dot : Dot
var grabbed_dot : Dot
var tracked_dots : Dictionary #array of dot ID's being tracked
var copied_dot : Dot

var tracked_dots_font : DynamicFont = DynamicFont.new()

var mouse_on_grid = false

var attribute_spawn_spot : Control

signal on_selection_made(dot)
signal on_deslelection()
signal on_dot_copied()
signal good_to_paste

func _ready():
	queued_dot.add_attributes()
	tracked_dots_font.font_data = load("res://Fonts/CREAMPUF.TTF")
	tracked_dots_font.size = 16

func switch_to_select():
	if mode != MODE.SELECT:
		deselect()
	mode = MODE.SELECT

func switch_to_line():
	if mode == MODE.SELECT:
		deselect()
		display_attributes(queued_dot)
	emit_signal("good_to_paste")
	mode = MODE.LINE

func switch_to_circle():
	if mode == MODE.SELECT:
		deselect()
		display_attributes(queued_dot)
	emit_signal("good_to_paste")
	mode = MODE.CIRCLE

func switch_to_pencil():
	if mode == MODE.SELECT:
		deselect()
		display_attributes(queued_dot)
	emit_signal("good_to_paste")
	mode = MODE.PENCIL


func draw_mouse(from : Node2D):
	from.draw_circle(mouse_pos + Vector2(.5,.5), 1, Color(0,0,0,.05))
	if mode == MODE.SELECT:
		from.draw_circle(mouse_pos + Vector2(.5,.5), .1, Color(0,0,0,.1))
	else:
		queued_dot.position = mouse_pos
		queued_dot.draw_on_selected(from)
	if mode == MODE.PENCIL:
		from.draw_rect(Rect2(mouse_pos, Vector2(1,1)), dot_color)
	if mode == MODE.CIRCLE:
		from.draw_circle(mouse_pos + Vector2(0.5,0.5), size*1.1, Color(1,1,1,.05))
		from.draw_circle(mouse_pos + Vector2(.5,.5), size, dot_color)
	if mode == MODE.LINE:
		from.draw_circle(mouse_pos + Vector2(0.5,0.5), size*1.3, Color(1,1,1,.05))
		from.draw_rect(Rect2(mouse_pos - Vector2(size-1,size-1), Vector2((size-1)*2 + 1, (size-1)*2 + 1)),dot_color)
	if line_time and drawing_line and mode != MODE.SELECT:
		var line_width = size*2 if mode != MODE.PENCIL else 2
		var line_color = dot_color
		if line_start.distance_to(line_end) * size * 2 > warning_area_thresh:
			line_width *= .95
			line_color = Color(1,1,0, .3)
		if line_start.distance_to(line_end) * size * 2 > limit_area_thresh:
			line_width *= .1
			line_color = Color(1,0,0)
		from.draw_line(line_start  + Vector2(.5,.5),line_end  + Vector2(.5,.5), line_color, line_width)
		from.draw_line(line_start  + Vector2(.5,.5),line_end  + Vector2(.5,.5), Color(0,0,0,1), 1)
		from.draw_circle(line_start + Vector2(.5,.5), size, Color(0,0,0,.1))
		from.draw_circle(line_start + Vector2(.5,.5), 1, Color(0,0,0,1))
		from.draw_circle(line_end + Vector2(.5,.5), size, Color(0,0,0,.1))
	
	if is_instance_valid(selected_dot) and selected_dot is Dot:
		if Grid.is_legit_dot(selected_dot):
			from.draw_circle(selected_dot.position + Vector2(.5,.5), 1.25, Color(0,0,0,.1))
			from.draw_circle(selected_dot.position + Vector2(.5,.5), .1, Color(0,0,0,.1))
			from.draw_rect(Rect2(selected_dot.position, Vector2(1,1)), Color(0,0,0), false)
			if not tracked_dots.has(selected_dot.ID) : selected_dot.draw_on_selected(from)
	
	for dot in tracked_dots.values():
		if dot is Dot:
			if Grid.is_legit_dot(dot):
				from.draw_rect(Rect2(dot.position, Vector2(1,1)), Color(0,0,0), false)
				from.draw_rect(Rect2(dot.position - Vector2(.1,.1), Vector2(1.2,1.2)), Color(1,1,0), false)
				dot.draw_on_selected(from)
			else:
				tracked_dots.erase(dot.ID)

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
			if grabbed_dot is PhysDot and (not get_dots_at_mouse()[0] is Dot):
				(grabbed_dot as PhysDot).set_position(mouse_pos)
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
	if mouse_on_grid:
		if event is InputEventMouseButton:
			if event.is_action_pressed("left_mouse"):
				if line_time:
					line_start = mouse_pos
					drawing_line = true
				if mode == MODE.SELECT:
					select()
					var at_mouse = get_dots_at_mouse()[0]
					if at_mouse is Dot:
						grabbed_dot = at_mouse
			if event.is_action_released("left_mouse"):
				drawing_line = false
				grabbed_dot = null
				if line_time and mode != MODE.SELECT:
					line_end = mouse_pos
					make_line()

var size_scale = .4
func make_line():
	if line_start.distance_to(line_end) * size * 2 > limit_area_thresh:
		return
	
	var direction = line_start.direction_to(line_end)
	var draw_pos = line_start

	while draw_pos.distance_to(line_end) > .5 * size:
		mouse_pos = Utils.quantize(draw_pos)
		if insert: insert()
		else: delete()
		direction = draw_pos.direction_to(line_end)
		draw_pos += direction * size * size_scale
	
	mouse_pos = Utils.quantize(Grid.grid_node.get_local_mouse_position())
	if insert: insert()
	else: delete()


func deselect():
	clear_display()
	selected_dot = null
	emit_signal("on_deslelection")

func select():
	var dots = get_dots_at_mouse()
	if dots[0] is Dot:
		selected_dot = dots[0]
		display_attributes(selected_dot)
		emit_signal("on_selection_made", selected_dot)

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
	
func is_dot_tracked(dot : Dot):
	return tracked_dots.has(dot.ID)
