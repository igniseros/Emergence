extends Control


onready var MouseTypes = [$Line, $Circle, $Pencil, $Select]
onready var ModeTypes = [$Mode/Insert, $Mode/Delete]

func _on_Select_toggled(button_pressed):
	if button_pressed:
		$Line.pressed = false
		$Circle.pressed = false
		$Pencil.pressed = false
		UIMouse.switch_to_select()
	$Mode.visible = not button_pressed
	if not are_any_pressed(MouseTypes):
		$Select.pressed = true


func _on_Line_toggled(button_pressed):
	if button_pressed:	
		$Select.pressed = false
		$Circle.pressed = false
		$Pencil.pressed = false
		UIMouse.switch_to_line()
		UIMouse.size = $Line/LineSize.value
		
	if not are_any_pressed(MouseTypes):
		$Line.pressed = true
	


func _on_Circle_toggled(button_pressed):
	if button_pressed:	
		$Select.pressed = false
		$Line.pressed = false
		$Pencil.pressed = false
		UIMouse.switch_to_circle()
		UIMouse.size = $Circle/CircleSize.value
		
	if not are_any_pressed(MouseTypes):
		$Circle.pressed = true


func _on_Pencil_toggled(button_pressed):
	if button_pressed:	
		$Select.pressed = false
		$Line.pressed = false
		$Circle.pressed = false
		UIMouse.switch_to_pencil()
	if not are_any_pressed(MouseTypes):
		$Pencil.pressed = true


func _on_Insert_toggled(button_pressed):
	if button_pressed:
		$Mode/Delete.pressed = false
		$Mode/DotChoice.visible = button_pressed
		$Mode/DotColor.visible = button_pressed
		UIMouse.insert = true
	$Mode/Override.visible = button_pressed
	if not are_any_pressed(ModeTypes):
		$Mode/Insert.pressed = true


func _on_Delete_toggled(button_pressed):
	if button_pressed:
		$Mode/Insert.pressed = false
		$Mode/DotChoice.visible = $Mode/Mask.pressed
		$Mode/DotColor.visible = $Mode/Mask.pressed
		UIMouse.insert = false
	$Mode/Mask.visible = button_pressed
	if not are_any_pressed(ModeTypes):
		$Mode/Delete.pressed = true

func _on_Mask_toggled(button_pressed):
	$Mode/DotChoice.visible = button_pressed
	$Mode/DotColor.visible = button_pressed
	UIMouse.mask = button_pressed
	

func are_any_pressed(checkboxes : Array):
	for c in checkboxes:
		c = c as CheckBox
		if c.pressed:
			return true
	return false


func _on_DotChoice_item_selected(index):
	$Mode/DotColor.color = TheGreatConnection.COLOR.keys()[index]
	UIMouse.dot_class = TheGreatConnection.COLOR.values()[index]
	UIMouse.dot_color = TheGreatConnection.COLOR.keys()[index] - Color(0,0,0,.30)
	var nqueued_dot = UIMouse.dot_class.new()
	nqueued_dot.add_attributes()
	UIMouse.change_queued_dot(nqueued_dot)


func _on_CircleSize_value_changed(value):
	$Circle/CircleSizeLabel.text = str(value)
	$Circle.pressed = true
	UIMouse.size = value

func _on_LineSize_value_changed(value):
	$Line/LineSizeLabel.text = str(value)
	$Line.pressed = true
	UIMouse.size = value

func _on_Override_toggled(button_pressed):
	UIMouse.override = button_pressed
