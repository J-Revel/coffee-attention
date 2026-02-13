extends ScreenRoot

@onready var _master_bus_index = AudioServer.get_bus_index("Master")
@onready var _music_bus_index = AudioServer.get_bus_index("Music")
@onready var _sfx_bus_index = AudioServer.get_bus_index("SFX")

func _ready():
	super._ready()
	%"Master Slider".value = AudioServer.get_bus_volume_linear(_master_bus_index)
	%"Music Slider".value = AudioServer.get_bus_volume_linear(_music_bus_index)
	%"SFX Slider".value = AudioServer.get_bus_volume_linear(_sfx_bus_index)

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_master_bus_index, linear_to_db(value))
	
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_music_bus_index, linear_to_db(value))
	
func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_sfx_bus_index, linear_to_db(value))


func _on_back_button_pressed() -> void:
	close_menu()
