class_name Matrix

var elements : Array = []

func _init(elems : Array):
	elements = elems

func _to_string():
	var ret = ""
	for e in elements:
		ret += "| "
		for ee in e:
			ret += str(ee) + " "
		ret += "|\n"
	return ret

func multiply_vector(v : Vector):
	var ret_elems = []
	var row = 0
	#for every row in the matrix
	for r in elements:
		var row_total= 0
		#add the vector product to the output vector
		var col = 0
		for c in r:
			row_total += c * v.elements[col]
			col += 1
		ret_elems.append(row_total)
		row += 1
		#give it back
	return Vector.new(ret_elems)
