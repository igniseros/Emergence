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
var dot_color : Color = WallDot.new().color_one - Color(0,0,0,.30)


func draw_mouse(from : Node2D):
	from.draw_circle(mouse_pos + Vector2(.5,.5), 1.25, Color(1,1,1,.25))
	if mode == MODE.SELECT:
		from.draw_circle(mouse_pos + Vector2(.5,.5), .1, Color(0,0,0))
	if mode == MODE.PENCIL:
		from.draw_rect(Rect2(mouse_pos, Vector2(1,1)), dot_color)
	if mode == MODE.CIRCLE:
		from.draw_circle(mouse_pos + Vector2(.5,.5), size, dot_color)
	if mode == MODE.LINE:
		from.draw_rect(Rect2(mouse_pos - Vector2(size-1,size-1), Vector2((size-1)*2 + 1, (size-1)*2 + 1)),dot_color)


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

func clicked():
	if Input.is_action_pressed("left_mouse"):
		if mode == MODE.SELECT:
				select()
		elif insert:
			insert()
		else:
			delete()

func select():
	pass

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
