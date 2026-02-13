extends Node2D
class_name DragSystem

var hovered_elements: Array[Draggable]
var dragged_element: Draggable
var _dragging: bool

func _process(delta: float) -> void:
	if !_dragging && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if len(hovered_elements) > 0:
			dragged_element = hovered_elements[0]
			move_child(dragged_element, -1)
			dragged_element.grab_start.emit()
		_dragging = true
	elif _dragging && !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_dragging = false
		if dragged_element != null:
			dragged_element.grab_end.emit()
		dragged_element = null
		
func on_hover_start(draggable: Draggable):
	if !hovered_elements.has(draggable):
		hovered_elements.append(draggable)
	
func on_hover_end(draggable: Draggable):
	for i in range(len(hovered_elements)-1, -1, -1):
		if hovered_elements[i] == draggable:
			hovered_elements.remove_at(i)
