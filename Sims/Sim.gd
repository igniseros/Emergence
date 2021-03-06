extends Node2D

export var use_timer = false

onready var grid_node = $GridNode

func _ready():
	set_process(false)
	if not use_timer: set_process(true)
	wait_ready()

func _on_TickTimer_timeout():
	if(use_timer):
		grid_node.tick()

func _process(delta):
	wait_update()
	pass

export var time = 0
export var progress_delta = 0.01
var percent = 0
func wait_ready():
	print("pre-processing")	
	set_process(true)
	grid_node.draw = false

func wait_update():
	grid_node.tick()
	if(Grid.time > time and not grid_node.draw):
		print("100% processed")
		grid_node.draw = true
	else:
		if(Grid.time*100/float(time+ 1) > (percent+progress_delta) and not grid_node.draw):
			print(str(percent) + "% processed (" + str(Grid.time) + " ticks)")
			percent = Grid.time*100 / float(time)
