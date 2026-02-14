extends Node2D
class_name DragSystem

var hovered_elements: Array[Draggable]
var actually_hovered_element: Draggable
var dragged_element: Draggable
var _dragging: bool

	
func _process(delta: float) -> void:
	if !_dragging && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if actually_hovered_element != null:
			dragged_element = actually_hovered_element
			move_child(dragged_element.grab_root, -1)
			dragged_element.grab_start.emit()
		_dragging = true
	elif _dragging && !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_dragging = false
		_update_hover()
		if dragged_element != null:
			dragged_element.grab_end.emit()
		dragged_element = null
	
		
func _update_hover():
	var new_hovered_element = null
	if len(hovered_elements) > 0:
		var max_index = -1
		for hovered_element in hovered_elements:
			var index = hovered_element.grab_root.get_index()
			if index > max_index:
				new_hovered_element = hovered_element
				max_index = index
	if new_hovered_element != actually_hovered_element:
		if actually_hovered_element:
			actually_hovered_element.hover_end.emit()
		if new_hovered_element:
			new_hovered_element.hover_start.emit()
		actually_hovered_element = new_hovered_element
		
func on_hover_start(draggable: Draggable):
	if !hovered_elements.has(draggable):
		hovered_elements.append(draggable)
	if !_dragging:
		_update_hover()
	
func on_hover_end(draggable: Draggable):
	for i in range(len(hovered_elements)-1, -1, -1):
		if hovered_elements[i] == draggable:
			hovered_elements.remove_at(i)
	if !_dragging:
		_update_hover()
