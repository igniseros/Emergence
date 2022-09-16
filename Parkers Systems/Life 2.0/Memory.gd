class_name Memory

var mem = []
var size = 0

func _init(size):
	self.size = size
	

func add_mem(m):
	if mem.size() == size:
		mem.remove(size-1)
	mem.insert(0, m)

func getmem():
	return mem
