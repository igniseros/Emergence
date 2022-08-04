class_name SimpleBrain

var matrix : Matrix

func _init(inputs : int, outputs : int, default_val : float, start_random : bool, rand_amount : float):
	#make the brain
	var rows = []
	#for every output
	for output in range(outputs):
		#we need a vector with length : inputs
		var row = []
		for input in range(inputs):
			#if random make random, if uniform make uniform
			if start_random: 
				var a = ((randf()-.5) * 2 *rand_amount) + default_val
				row.append(a)
			else: row.append(default_val)
		rows.append(Vector.new(row))
	
	matrix = Matrix.new(rows)

#takes an input and gives an output
func think(input : Vector) -> Vector:
	return matrix.multiply_vector(input).normalize()

#returns a single output as the chosen one
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
	
	return max_o_indexs[floor(rand_range(0,max_o_indexs.size()))]

#input : represents what the brain saw
#strength : represents how good or bad the brains behavior was in response to the input (+ meaning better)
func adjust_behavior_natural(input : Vector, pos_strength : float, neg_strength : float, minimum : float):
	var current_output : Vector = think(input) #get current behavior output
	#find the largest output element
	var current_output_max = current_output.get_largest_elements_index()
	
	#for each element
	for i in range(current_output.elements.size()):
		#if the element is the largest output element
		if i == current_output_max and pos_strength != 0: #adjust the row
			adjust_single_row(input, pos_strength, i, minimum)
		elif neg_strength != 0: #negativly adjust the rest of the rows
			adjust_single_row(input, -1 * neg_strength, i, minimum)

func adjust_behavior_forced(input : Vector, pos_strength : float, neg_strength : float, index_forced : int, minimum : float):
	var current_output_max = index_forced
	var one_right = false
	if pos_strength >= 0: one_right = true
	#for each element
	for i in range(matrix.size()[0]):
		#if the element is the largest output element
		if i == current_output_max and pos_strength != 0: #adjust the row
			adjust_single_row(input, pos_strength, i, minimum)
		elif neg_strength != 0: #negativly adjust the rest of the rows
			adjust_single_row(input, -1 * neg_strength, i, minimum)

func adjust_single_row(input : Vector, strength : float, row : int, minimum : float):
	#for each element in the row
	for i in range(matrix.rows[row].elements.size()):
		#adjust the element based on strength * input[i]
		(matrix.rows[row] as Vector).elements[i] += (strength * input.get_elem(i)) + minimum
		matrix.rows[row]= (matrix.rows[row] as Vector)

func _to_string():
	return matrix.to_string()

#modified sigmoid
func sigmoid(x):
	var ratio = 1.0
	return 1.0/(1.0 + exp(-x/ratio))
