extends Label

func _ready():
	Grid.connect("_on_tick", self, "_on_tick")

func _on_tick():
	text = "Tick: " + str(Grid.time)
