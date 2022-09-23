class_name LifeBrain

var weight_matrix : Matrix
var bias_vector : Vector

var last_answer = -1
var last_input : Vector = Vector.new([1,0])
var last_output : Vector = Vector.new([1,0])

func _init(inputs, outputs, copyfrom = null):
	if copyfrom != null:
		copy_from_parent(copyfrom)
	else:
		make_new_brain(inputs, outputs)

func copy_from_parent(copyfrom):
	weight_matrix = copyfrom.weight_matrix.copy()
	bias_vector = copyfrom.bias_vector.copy()

func make_new_brain(inputs, outputs):
	var weight_vector_array  = []
	bias_vector = Vector.new([])
	
	#for every output
	for output in range(outputs):
		#we need a vector with length : inputs
		var weight_vector = []
		for input in range(inputs):
			#make random
			weight_vector.append((randf()-.5) * 2)
		weight_vector_array.append(Vector.new(weight_vector))
		bias_vector.elements.append((randf()-.5) * 2)
	
	weight_matrix = Matrix.new(weight_vector_array)

func think(input : Vector) -> Vector:
	last_input = input
	last_output = weight_matrix.multiply_vector(input).add(bias_vector)
	return last_output

func condensed_think(input : Vector) -> float:
	var output = think(input)
	
	var i = 0
	var max_o = 0
	var max_o_indexs = []
	#find the biggest output and what it is tied with
	for o in output.elements:
		if i==0: max_o = o
		
		if o == max_o:
			max_o_indexs.append(i)

		if o > max_o: 
			max_o = o
			max_o_indexs = [i]
		i += 1
	
	last_answer = max_o_indexs[floor(rand_range(0,max_o_indexs.size()))]
	return last_answer

func mutate(scale):
	for vector in weight_matrix.rows:
		for i in range(len(vector.elements)):
			var weight_nudge = (randf()-.5) * 2 * scale
			vector.elements[i] += weight_nudge
	
	for i in range(len(bias_vector.elements)):
			var bias_nudge = (randf()-.5) * 2 * scale
			bias_vector.elements[i] += bias_nudge

#splits:
# elem,elem,elem
# row|row|row
# weight_matrix@bias_vector
func get_save_string():
	var s_string = weight_matrix.get_save_string() + "@" + bias_vector.get_save_string()
	return s_string


func stunt():
	bias_vector = bias_vector.normalize()
	for row in weight_matrix.rows:
		row = row.normalize()
