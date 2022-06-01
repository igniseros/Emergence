class_name ComplexMemoryBrain
#not really working
var brains : Array = []
var memory_sze
var memory_weight_base = 1
var memory_weight_ratio = 1

func _init(neurons_per_layer : Array, default_val : float, start_random : bool, rand_amount : float, mem_size : int,\
mem_weight_base : float, mem_weight_ratio : float):
	memory_sze = mem_size
	memory_weight_base = mem_weight_base
	memory_weight_ratio = mem_weight_ratio
	var i = 0
	for v in neurons_per_layer:
		#if this isn't the last layer
		if i != neurons_per_layer.size() - 1:
			#add a brain of the correct size
			brains.append(SimpleMemoryBrain.new(neurons_per_layer[i],neurons_per_layer[i+1],default_val,start_random,rand_amount,mem_size))
		i += 1

func get_thought_process(input: Vector) -> Array:
	var collection = [input]
	
	var out : Vector = input
	for b in brains:
		out = b.think(out)
		collection.append(out)
	
	return collection

#returns an output
func think(input : Vector) -> Vector:
	var out : Vector = input
	for b in brains:
		out = b.think(out)
	
	return out

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

func adjust_behavior_with_memory(input : Vector, pos_strength : float, neg_strength : float, minimum : float):
	var though_process = get_thought_process(input)
	#adjust each brain
	var i = 0
	for b in brains:
		b = b as SimpleMemoryBrain
		b.adjust_behavior_forced_with_memory(though_process[i], pos_strength, neg_strength,\
		though_process[i+1].get_largest_elements_index(), minimum,memory_weight_base,memory_weight_ratio)
		i += 1

func adjust_behavior_forced_with_memory(thought_process : Array, pos_strength : float, neg_strength : float, minimum : float):
	#adjust each brain
	var i = 0
	for b in brains:
		b = b as SimpleMemoryBrain
		b.adjust_behavior_forced_with_memory(thought_process[i], pos_strength, neg_strength,\
		thought_process[i+1].get_largest_elements_index(), minimum,memory_weight_base,memory_weight_ratio)
		i += 1

func _to_string():
	var s = ""
	var i = 0
	for b in brains:
		if i != 0:
			s += "[[--------feeds into--------]]\n"
		s += b.to_string()
		i += 1
	return s
