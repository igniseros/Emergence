extends PhysDot
class_name DodgingBrainDot
#the goal here is to make a dot that learns to move towards food
#inputs: checks to see if there are dots in the surrounding box and has a memory of it's last few moves
#outputs: (size 8)
var vision_range = 14
var memory_size = 5
var brain_memory_size = 30
var base_memory_weight = .1
var memory_weight_ratio = .95
var batch_size = 3
var brain : ComplexBatchMemoryBrain = ComplexBatchMemoryBrain.new([(PDF.box_around_self(vision_range).size()*2) + (memory_size*16) + 2,8],0,true,.05,\
memory_size,base_memory_weight,memory_weight_ratio,batch_size)
var total_score = 0



var memory = []
var last_output : Vector

var days_hungry = 0
var days_eaten = 0
var food_dist = vision_range
var got_closer = false
var _food_vision = ""
var _non_food_vision = ""

var score_memory_size : int  = 20
var score_memory = []
var score_rate = 0

const CHANGE_SCALE = 4
func will_tick():
	return true

func _init():
	#set name
	name = StringAttribute.new("Dodging Brain")
	#set clors
	color_one = Color(.25,.55,1)
	color_two = Color(.25,.55,1)
	color_three = Color(.25,.55,1)
	
	for i in range(memory_size):
		memory.append([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
		
	for i in range(score_memory_size):
		score_memory.append(0)
	

func tick():
	#look around
	_food_vision = ""
	_non_food_vision = ""
	var dist_from_food = vision_range*2
	var crude_inputs = []
	var fv : Array= []
	var nfv : Array = [] #non food vision now represents legal spaces to move into
	for i in range((vision_range*2)+1):
		var fve = []
		var nfve = []
		for j in range((vision_range*2)+1):
			fve.append(0)
			nfve.append(0)
		fv.append(Vector.new(fve))
		nfv.append(Vector.new(nfve))
	var food_vision = []
	_food_vision = Matrix.new(fv)
	var non_food_vision = []
	_non_food_vision = Matrix.new(nfv)
	for dot in PDF.look_at_array(self,PDF.box_around_self(vision_range)):
		if dot is PhysDot:
			dot = dot as PhysDot
			if dot.name == "Food" and position.distance_to(dot.position) < dist_from_food:
				dist_from_food = position.distance_to(dot.position)
			var dot_dir = (dot.position - position) + Vector2(vision_range,vision_range)
			food_vision.append(1 if dot.name == "Food" else 0)
			_food_vision.rows[dot_dir.y].elements[dot_dir.x] = 1 if dot.name == "Food" else 0
			non_food_vision.append(1 if dot.name == "Food" else 0)
			_non_food_vision.rows[dot_dir.y].elements[dot_dir.x] = 1 if dot.name == "Food" else 0
		else:
			food_vision.append(0)
			non_food_vision.append(1)
	#how much did the distance change (+ means more distance, - means less distance)
	var diff_dist_from_food = dist_from_food - food_dist
	got_closer = diff_dist_from_food < 0 #did we get closer to food?
	food_dist = dist_from_food
	crude_inputs.append(dist_from_food)
	crude_inputs.append(days_hungry)
	crude_inputs.append_array(food_vision)
	crude_inputs.append_array(non_food_vision)
	
	for m in memory:
		crude_inputs.append_array(m)
	
	#choose direction to go in
	var input = Vector.new(crude_inputs)
	var last_process = brain.get_thought_process(input)
	last_output = last_process[last_process.size()-1] as Vector
	var output = last_output.get_largest_elements_index()
	
	#move
	move(PDF.box_around[output])
	
	var eaten = false
	#eat a food if one is near and reward brain
	for dot in PDF.look_at_array(self,PDF.box_around):
		if dot is Dot and dot.name == "Food":
			Grid.remove_dot(dot)
#			brain.adjust_behavior_forced_with_memory(input, (.001 + (days_eaten/20000)) * CHANGE_SCALE, 0,output,.00,base_memory_weight,memory_weight_ratio)
			brain.store_and_adjust(last_process, (.004 * (1 + (4*(score_rate+days_eaten)))) * CHANGE_SCALE)
			color_one = Color(.5,1,.5)
			total_score += 1
			eaten = true
			days_hungry = 0
			days_eaten +=1
			break;
	#if not eaten make hurt just right
	if not eaten:
		days_hungry +=1
		days_eaten = 0
		var hunger_mod = 1 if days_hungry < 5 else 1 + (clamp(days_hungry,0,60) / 40)
		hunger_mod *= 1+(dist_from_food/20)
		if dist_from_food >= vision_range*2: hunger_mod *= 2
		if got_closer and not eaten: #if we get closer to food, give small reward
#			hunger_mod = -1/10
			color_one = Color(.5,.5,1)
		else:
			color_one = Color(1,0,0)
#		brain.adjust_behavior_forced_with_memory(input,-.001 * hunger_mod * CHANGE_SCALE,0,output,.000,base_memory_weight,memory_weight_ratio)
		brain.store_and_adjust(last_process,-.004 * hunger_mod * CHANGE_SCALE)
	
	add_score_memory()
	add_memory(output)
	
	store_info(str(total_score))

func get_report():
	var rep_mems = ""
	for i in range(5):
		rep_mems += str(memory[i]) + "\n"
	return "Food Vision:\n"+str(_food_vision)+"Memory:\n"+str(rep_mems) + "Total Score: " + str(total_score) + "   days hungry : " + str(days_hungry) \
	+ "\nFood Distance: " + str(food_dist) + "   Got Closer: " + str(got_closer) + "\nScore Rate: " + str(score_rate)

func add_memory(m):
	#move all of the memories
	var i=0
	for mem in memory:
		if i != memory_size-1:
			memory[memory_size-1-i] = memory[memory_size-2-i]
		i+=1
	#add newest memory
	var mem_slot = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	mem_slot[m + (0 if got_closer else 8)] = 1
	memory[0] = mem_slot

func add_score_memory():
	var i=0
	for mem in score_memory:
		if i != score_memory_size-1:
			score_memory[score_memory_size-1-i] = score_memory[score_memory_size-2-i]
		i+=1
	#add newest memory
	score_memory[0] = total_score
	score_rate = (total_score - score_memory[score_memory_size-1]) / float(score_memory_size)
	
