extends Action
class_name DieAction

func _init(attributes = []):
	_attributes = attributes

func play(dot):
	dot.die(false)

func _to_string():
	return "[Die Action]"
