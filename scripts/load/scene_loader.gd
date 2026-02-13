extends Node
class_name SceneLoaderSingleton

signal scene_loaded

@export var loading_screen_scene: PackedScene

@export_group("Debug")
@export var log_enabled: bool = false
@export var min_load_duration: float = 2

var _load_time: float = 0

var _loading_scene_path: String

func load_scene(scene_path: String):
	_load_time = 0
	_loading_scene_path = scene_path
	if ResourceLoader.has_cached(scene_path):
		call_deferred("emit_signal", "scene_loaded")
		show_loaded_scene(get_resource(scene_path))
		return
	ResourceLoader.load_threaded_request(scene_path)
	set_process(true)
	show_loading_screen()
	
func show_loaded_scene(resource: Resource) -> void:
	var err = get_tree().change_scene_to_packed(resource)
	if err:
		push_error("failed to change scenes: %d" % err)
		get_tree().quit()
	
func show_loading_screen():
	var err = get_tree().change_scene_to_packed(loading_screen_scene)
	if err:
		push_error("failed to display loading screen: %d" % err)
		get_tree().quit()

func get_resource(scene_path: String) -> Resource:
	if ResourceLoader.has_cached(scene_path):
		return ResourceLoader.load(scene_path)
	var current_loaded_resource := ResourceLoader.load_threaded_get(scene_path)
	if current_loaded_resource != null:
		return current_loaded_resource
	return null

func _process(delta: float) -> void:
	_load_time += delta
	var status = ResourceLoader.load_threaded_get_status(_loading_scene_path)
	match(status):
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			set_process(false)
			print("Scene load error: %d", status)
		ResourceLoader.THREAD_LOAD_LOADED:
			if _load_time > min_load_duration:
				emit_signal("scene_loaded")
				set_process(false)
				show_loaded_scene(get_resource(_loading_scene_path))
				_loading_scene_path = ""
		
