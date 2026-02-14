extends Control
class_name MenuContainer

var _screen_cursor: int = 0

@export var starting_screen: PackedScene
@export var pause_screen: PackedScene

func _ready():
	if starting_screen:
		show_screen(starting_screen, false)
	
func _process(delta: float):
	if Input.is_action_just_pressed("pause"):
		if _screen_cursor > 1:
			pop_screen()
		elif _screen_cursor == 0:
			show_screen(pause_screen, false)

func show_screen(screen_prefab: PackedScene, replace_current: bool):
	if !screen_prefab:
		return
	var screen: ScreenRoot = screen_prefab.instantiate()
	add_child(screen)
	screen.on_open.emit()
	if _screen_cursor > 0:
		var previous_active: ScreenRoot = get_child(_screen_cursor-1)
		if replace_current:
			previous_active.on_close.emit()
		else:
			previous_active.on_focus_leave.emit()
			_screen_cursor += 1
	else:
		_screen_cursor += 1
	
func pop_screen():
	var to_pop: ScreenRoot = get_child(_screen_cursor-1)
	to_pop.on_close.emit()
	_screen_cursor -= 1
	var new_active: ScreenRoot = get_child(_screen_cursor-1)
	new_active.on_focus_return.emit()
