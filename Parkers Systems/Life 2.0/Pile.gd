class_name Pile

#scale = weight of new addition
var scale = .1

var val : float = 0

func _init(scale):
	self.scale = scale
	

func add(v : float):
	val *= 1 - scale
	v *= scale
	val += v
	return val

func getval():
	return val
