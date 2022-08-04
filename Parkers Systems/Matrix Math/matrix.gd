class_name Matrix

var rows : Array = []

func _init(r : Array):
	rows = r

func _to_string():
	var ret = ""
	for r in rows:
		ret += "| "
		for elem in r.elements:
			ret += str(elem) + " "
		ret += "|\n"
	return ret

func multiply_vector(v : Vector) -> Vector:
	var ret_elems = []
	var row = 0
	#for every row in the matrix
	for r in rows:
		#add the vector dot product to the output vector
		ret_elems.append(r.dot_product(v))
	return Vector.new(ret_elems)

func size():
	return [rows.size(), rows[0].size()]

#apply a function to each member
func apply_by_member(f : FuncRef):
	var cm = copy()
	var i = 0
	for r in cm.rows:
		var j = 0
		r = r as Vector
		for member in r.elements:
			cm.rows[i].elements[j] = f.call_func(cm.rows[i].elements[j])
			j += 1
		i += 1
	
	return cm

func copy():
	var crows = []
	for r in rows:
		var cr = []
		for m in r.elements:
			cr.append(m)
		crows.append(Vector.new(cr))
	return get_script().new(crows)

func empty(rows : int, cols : int):
	var crude_matrix = []
	for r in range(rows):
		crude_matrix.append(Vector.new([]).empty(cols))
	return get_script().new(crude_matrix)
