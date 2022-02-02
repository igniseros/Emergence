extends Node

func _ready():
	# map pixel art color in map to the corrisponding dot
	TheGreatConnection.add_color_connection(Color8(105, 52, 52), BugDot)
