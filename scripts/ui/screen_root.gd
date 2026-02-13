extends Control
class_name ScreenRoot

signal on_open
signal on_close
signal on_focus_return
signal on_focus_leave

func _ready():
	on_close.connect(destroy_immediately)

func destroy_immediately():
		print(get_tree())
		queue_free()

func open_menu(new_screen: PackedScene, replace: bool):
	var screen_container: MenuContainer = get_parent()
	screen_container.show_screen(new_screen, replace)

func close_menu():
	var screen_container: MenuContainer = get_parent()
	screen_container.pop_screen()
