extends ScreenRoot

@export var settings_screen: PackedScene

func _on_play_button_pressed() -> void:
	SceneLoader.load_scene("res://scenes/main/game_scene.tscn")


func _on_settings_button_pressed() -> void:
	open_menu(settings_screen, false)


func _on_close() -> void:
	print("CLOSE MENU")
	pass # Replace with function body.


func _on_focus_leave() -> void:
	modulate = Color.TRANSPARENT


func _on_focus_return() -> void:
	modulate = Color.WHITE
