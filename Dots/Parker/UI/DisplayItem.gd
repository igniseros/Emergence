class_name DisplayItem

var obj : Object
var getter : FuncRef
var setter : FuncRef
var type

func _init(object, getter_func : FuncRef, setter_func : FuncRef, Type):
	obj = object
	getter = getter_func
	setter = setter_func
	type = Type

