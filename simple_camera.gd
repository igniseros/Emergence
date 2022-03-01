extends Camera2D

export var speed = 1
export var zoom_speed = 1

func _ready():
	set_process(true)
	#Matrix text
	var m1 : Matrix = Matrix.new([[1,2],[3,4]])
	print(m1.to_string())
	var v1 : Vector = Vector.new([1,2])
	print("*\n" + str(v1) + "\n=")
	print(m1.multiply_vector(v1))
	
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		position.y -= speed * delta * zoom.x
	if Input.is_key_pressed(KEY_S):
		position.y += speed * delta * zoom.x
	if Input.is_key_pressed(KEY_A):
		position.x -= speed * delta * zoom.x
	if Input.is_key_pressed(KEY_D):
		position.x += speed * delta * zoom.x
	if Input.is_key_pressed(KEY_SHIFT):
		zoom *= 1 - (delta*zoom_speed)
	if Input.is_key_pressed(KEY_SPACE):
		zoom *= 1 + (delta*zoom_speed)
