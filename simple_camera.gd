extends Camera2D

export var speed = 1
export var zoom_speed = 1

func _ready():
	set_process(true)
	
func _process(delta):
	if UIMouse.mouse_on_grid:
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
