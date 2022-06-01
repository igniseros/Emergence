extends Node2D

export var use_timer = false
export var paused = false
var total = 0
var ticks = 0

onready var grid_node = $GridNode

func _ready():
	randomize()
	set_process(false)
	if not use_timer: set_process(true)
	wait_ready()
	print("gonna hope")
	TheGreatConnection.load_sim("user://sim.grid")
	

func _on_TickTimer_timeout():
	if paused: return
	if(use_timer):
		grid_node.draw = true
		Grid.tick()

func _process(delta):
	if paused or use_timer: return
	wait_update()
#	if Grid.time == 15:
#		TheGreatConnection.save_sim("user://sim.grid")

export var time = 0
export var progress_delta = 0.01
var percent = 0
func wait_ready():
	print("pre-processing")	
	set_process(true)
	grid_node.draw = false

func wait_update():
	
	Grid.tick()
	if(Grid.time > time and not grid_node.draw):
		print("100% processed")
		grid_node.draw = true
	else:
		if(Grid.time*100/float(time+ 1) >= (percent+progress_delta) and not grid_node.draw):
			percent = Grid.time*100 / float(time)
			print(str(percent) + "% processed (" + str(Grid.time) + " ticks " + str(Grid.tick_registrer.size()) + " ticking dots)")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_TAB:
			paused = not paused
			grid_node.update()
		
		if event.pressed and event.scancode == KEY_ENTER:
			var file_date = str(OS.get_date()["month"]) + "-" + str(OS.get_date()["day"]) + "-" + str(OS.get_date()["year"]) + "-"
			var file_time = str(OS.get_time()["hour"]) + str(OS.get_time()["minute"]) + str(OS.get_time()["second"])
			var file_path = "user://output_" + file_date+file_time + ".txt"
			TheGreatConnection.save_data(file_path)
			print("Saved at: " + file_path)
