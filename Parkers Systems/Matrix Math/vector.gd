class_name Vector

var elements : Array = []

func _init(elems : Array):
	elements = elems

func _to_string():
	return str(elements)

func dot_product(v : Vector):
	var prod = 0
	var pos = 0
	for e in v.elements:
		prod += e * elements[pos]
		pos += 1
	return prod

func get_elem(i : int):
	return elements[i]

func get_largest_elements_index():
	#sorry for hardcoding, am lazy rn
	var current_maximum = -10000000.0
	var current_max_index = 0
	var i = 0
	for e in elements:
		if e > current_maximum:
			current_maximum = e
			current_max_index = i
		i += 1
	
	return current_max_index

func size():
	return elements.size()

#apply a function to each member
func apply_by_member(f : FuncRef):
	var cv = copy() as Vector
	var i = 0
	for member in elements:
		cv.elements[i] = f.call_func(cv.elements[i])
		i += 1
	
	return cv

func copy() -> Vector:
	var cvec = []
	for m in elements:
		cvec.append(m)
	return get_script().new(cvec)

func get_norm():
	return sqrt(dot_product(self))

var norm = 0
func normalize() -> Vector:
	norm = get_norm()
	return apply_by_member(funcref(self,"_normalize_helper"))

func _normalize_helper(member):
	return member/norm

func add(v : Vector) -> Vector:
	var ret = copy()
	for e in range(ret.elements.size()):
		ret.elements[e] += v.elements[e]
	return ret

func empty(size : int) -> Vector:
	var crude_ret = []
	for i in range(size):
		crude_ret.append(0)
	return get_script().new(crude_ret)

func get_save_string():
	var first = true
	var s_string = ""
	for e in elements:
		if first: 
			s_string += str(e)
			first = false
		else: s_string += "," + str(e)
	return s_string


