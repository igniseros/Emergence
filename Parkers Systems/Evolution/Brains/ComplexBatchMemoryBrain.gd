extends ComplexMemoryBrain
class_name ComplexBatchMemoryBrain

var _batch_size = 10

var _thoughts_batch  = []
var _adjustment_batch : Vector

var _batch_timer = _batch_size

func _init(neurons_per_layer : Array, default_val : float, start_random : bool, rand_amount : float, mem_size : int,\
mem_weight_base : float, mem_weight_ratio : float, batch_size : int).(neurons_per_layer, default_val, start_random, rand_amount, mem_size,\
mem_weight_base, mem_weight_ratio):
	#set batch values
	_batch_size = batch_size
	_batch_timer = _batch_size-1
	
	#initalize empty matricies
	_thoughts_batch = []
	for i in range(_batch_size):
		_thoughts_batch.append([])
	_adjustment_batch = Vector.new([]).empty(_batch_size)
	

func store_and_adjust(thought_process : Array, adjustment : float):
	_thoughts_batch[_batch_timer] = thought_process 
	_adjustment_batch.elements[_batch_timer] = adjustment
	
	if _batch_timer == 0:
		_batch_timer =  _batch_size
		run_batch()
	
	_batch_timer -= 1
	
func run_batch():
	var total_thoughts = _thoughts_batch[0]
	var total_adjustments = 0
	
	for i in range(_batch_size):
		total_adjustments += _adjustment_batch.elements[i]
		if i != 0:
			for t in range(_thoughts_batch[i].size()):
				total_thoughts[t].add(_thoughts_batch[i][t])
	
	adjust_behavior_forced_with_memory(total_thoughts,total_adjustments,0,0)
	
