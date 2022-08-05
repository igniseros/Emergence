extends OptionButton

func _ready():
	for v in TheGreatConnection.COLOR.values():
		var dot = v.new()
		add_item(dot.name)
