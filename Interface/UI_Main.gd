extends CanvasLayer

var is_size_up_pressed= false
var is_size_down_pressed= false
var time_per_size_up = .25

var elapsed_time = 0

func _input(event):
	if UIMouse.mouse_on_grid:
		if event is InputEventKey:
			if event.is_action_pressed("circle"):
				$Edit/Circle.pressed = true
			if event.is_action_pressed("line"):
				$Edit/Line.pressed = true
			if event.is_action_pressed("pencil"):
				$Edit/Pencil.pressed = true
			if event.is_action_pressed("select"):
				$Edit/Select.pressed = true
			if event.is_action_pressed("pause"):
				Grid.paused = not Grid.paused
			if event.is_action_pressed("tick"):
				Grid.tick()
			if event.is_action_pressed("fancy draw"):
				$"Sim Settings/FancyDrawCheckBox".pressed = not $"Sim Settings/FancyDrawCheckBox".pressed
			if event.is_action_pressed("use timer"):
				$"Sim Settings/UseTimerCheckBox".pressed = not $"Sim Settings/UseTimerCheckBox".pressed
			if event.is_action_pressed("override"):
				$Edit/Mode/Override.pressed = not $Edit/Mode/Override.pressed
			if event.is_action_pressed("mask"):
				$Edit/Mode/Mask.pressed = not $Edit/Mode/Mask.pressed
			if event.is_action_pressed("insert"):
				$Edit/Mode/Insert.pressed = true
			if event.is_action_pressed("delete"):
				$Edit/Mode/Delete.pressed = true
			if event.is_action_pressed("increase size"):
				is_size_up_pressed = true
				if UIMouse.mode == UIMouse.MODE.LINE:
					$Edit/Line/LineSize.value += 1
				if UIMouse.mode == UIMouse.MODE.CIRCLE:
					$Edit/Circle/CircleSize.value += 1
			if event.is_action_released("increase size"):
				is_size_up_pressed = false
				elapsed_time = 0
			if event.is_action_pressed("decrease size"):
				is_size_down_pressed = true
				if UIMouse.mode == UIMouse.MODE.LINE:
					$Edit/Line/LineSize.value -= 1
				if UIMouse.mode == UIMouse.MODE.CIRCLE:
					$Edit/Circle/CircleSize.value -= 1
			if event.is_action_released("decrease size"):
				is_size_down_pressed = false
				elapsed_time = 0
			if event.is_action_pressed("ui_right"):
				if UIMouse.mode != UIMouse.MODE.SELECT:
					var next_item = ($Edit/Mode/DotChoice.selected + 1) % $Edit/Mode/DotChoice.get_item_count()
					$Edit/Mode/DotChoice.select(next_item)
					$Edit/Mode/DotChoice.emit_signal("item_selected", next_item)
			if event.is_action_pressed("ui_left"):
				if UIMouse.mode != UIMouse.MODE.SELECT:
					var next_num = $Edit/Mode/DotChoice.selected - 1
					if next_num < 0:
						next_num = $Edit/Mode/DotChoice.get_item_count() - 1
					var next_item = (next_num) % $Edit/Mode/DotChoice.get_item_count()
					$Edit/Mode/DotChoice.select(next_item)
					$Edit/Mode/DotChoice.emit_signal("item_selected", next_item)
			if event.is_action_pressed("load"):
				$"Save and load/LoadButton"._on_LoadButton_pressed()
			if event.is_action_pressed("save as"):
				$"Save and load/SaveAsButton"._on_SaveAsButton_pressed()
			if event.is_action_pressed("save"):
				$"Save and load/SaveButton"._on_SaveButton_pressed()
			if event.is_action_pressed("linetime"):
				UIMouse.line_time = true
			if event.is_action_released("linetime"):
				UIMouse.line_time = false
			if event.is_action_pressed("copy"):
				if not $"Dot Attributes/CopyDotAttributesButton".disabled:
					$"Dot Attributes/CopyDotAttributesButton"._on_CopyDotAttributesButton_pressed()
			if event.is_action_pressed("paste"):
				if not $"Dot Attributes/PasteDotAttributesButton".disabled:
					$"Dot Attributes/PasteDotAttributesButton"._on_PasteDotAttributesButton_pressed()
			if event.is_action_pressed("track"):
				if not $"Dot Attributes/TrackDotButton".disabled:
					$"Dot Attributes/TrackDotButton"._on_TrackDotButton_pressed()


func _process(delta):
	if is_size_up_pressed:
		change_size(delta, +1)
	if is_size_down_pressed:
		change_size(delta, -1)


func change_size(delta, amount):
	elapsed_time += delta
	
	if elapsed_time > time_per_size_up:
		elapsed_time = 0
		if UIMouse.mode == UIMouse.MODE.LINE:
			$Edit/Line/LineSize.value += amount
		if UIMouse.mode == UIMouse.MODE.CIRCLE:
			$Edit/Circle/CircleSize.value += amount
