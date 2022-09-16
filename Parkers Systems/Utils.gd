extends Node

func shuffleList(list):
	var shuffledList = [] 
	var indexList = range(list.size())
	for i in range(list.size()):
		var x = randi()%indexList.size()
		shuffledList.append(list[indexList[x]])
		indexList.remove(x)
	return shuffledList

func quantize(pos : Vector2 ) -> Vector2:
	return pos.floor()


#-------------
# Brain stuff
#-------------
func draw_square(from : CanvasItem, position : Vector2, color : Color, scale : float, offset : Vector2):
	from.draw_rect(Rect2((position * scale) + offset, Vector2(scale,scale)), color)

func calc_color(elem):
	var val = (elem + 1) / 2
	return Color(val,0,1-val)

#expects numbers between -1 and 1
func draw_vector(from : CanvasItem, vector : Vector, scale : float, offset : Vector2 = Vector2(0,0)):
	for x in range(vector.size()):
		var color = calc_color(vector.get_elem(x))
		draw_square(from,Vector2(x,0), color, scale, offset)

#expects numbers between -1 and 1
func draw_matrix(from : CanvasItem, matrix : Matrix, scale : float, offset : Vector2):
	for x in range(matrix.size()[0]):
		for y in range(matrix.size()[1]):
			var color = calc_color(matrix.get_elem(x,y))
			draw_square(from, Vector2(x,y), color, scale, offset)

#------------------
#   Save Strings
#------------------
func vector_from_save_string(s_string : String) -> Vector:
	var elems = []
	for s in s_string.split(","):
		elems.append(float(s))
	return Vector.new(elems)

func matrix_from_save_string(s_string : String) -> Matrix:
	var rows = []
	for r_string in s_string.split("|"):
		rows.append(vector_from_save_string(r_string))
	return Matrix.new(rows)

func life_brain_from_save_string(s_string : String):
	var split_s_string = s_string.split("@")
	var new_brain = LifeBrain.new(1,1)
	new_brain.weight_matrix = matrix_from_save_string(split_s_string[0])
	new_brain.bias_vector = vector_from_save_string(split_s_string[1])
	return new_brain
