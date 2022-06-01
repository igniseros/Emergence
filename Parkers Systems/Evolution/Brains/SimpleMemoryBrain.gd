extends SimpleBrain
class_name SimpleMemoryBrain

var mem_size = -1
var input_memory : Matrix
var output_memory : Matrix

func _init(inputs : int, outputs : int, default_val : float, start_random : bool, rand_amount : float, memory_size : int).(inputs,outputs,default_val,start_random,rand_amount):
	mem_size = memory_size
	
	#populate input_memory
	var ip_mem_crude = []
	for ip_mem_tmp_i in range(memory_size):
		var ip_mem_tmp_crude = []
		for ip_mem_tmp_crude_length_i in range(inputs):
			ip_mem_tmp_crude.append(0)
		ip_mem_crude.append(Vector.new(ip_mem_tmp_crude))
	
	input_memory = Matrix.new(ip_mem_crude)
	
	#populate output memory
	var op_mem_crude = []
	for op_mem_tmp_i in range(memory_size):
		var op_mem_tmp_crude = []
		for op_mem_tmp_crude_length_i in range(outputs):
			op_mem_tmp_crude.append(0)
		op_mem_crude.append(Vector.new(op_mem_tmp_crude))
	
	output_memory = Matrix.new(op_mem_crude)

func add_memory(input : Vector, output : Vector):
	_insert_signle_memory(input, input_memory)
	_insert_signle_memory(output, output_memory)

#helper function to move all memories and store latest memory
func _insert_signle_memory(mem : Vector, storage : Matrix):
	var rowindex = mem_size
	for r in storage.rows:
		if rowindex != mem_size:
			storage.rows[rowindex] = storage[rowindex-1]
		if rowindex == 0:
			storage.rows[rowindex] = mem
		rowindex -= 1
		

func adjust_behavior_forced_with_memory(input : Vector, pos_strength : float, neg_strength : float, index_forced : int, minimum : float, base_memory_strength : float, ratio_memory_strength : float):
	#adjust behavior based on memories
	var mem_num = 0
	var mem_strength_mod = base_memory_strength
	for imem in input_memory.rows:
		var out_index = (output_memory.rows[mem_num] as Vector).get_largest_elements_index()
		adjust_behavior_forced(imem,pos_strength*mem_strength_mod, neg_strength*mem_strength_mod, out_index, 0)
		
		mem_strength_mod *= ratio_memory_strength
		mem_num += 1
	
	#do regular adjustment
	adjust_behavior_forced(input,pos_strength,neg_strength,index_forced,minimum)
