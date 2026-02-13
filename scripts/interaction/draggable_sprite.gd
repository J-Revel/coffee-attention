extends StaticBody2D
class_name Draggable

var can_grab = false
var grabbed_offset = Vector2()
var random_movement: float = 30
var grabbed = false

signal grab_start
signal grab_end

		
func _on_grab_start():
	grabbed = true
	grabbed_offset = position - get_global_mouse_position()

func _on_grab_end():
	grabbed = false

func _ready():
	grab_start.connect(_on_grab_start)
	grab_end.connect(_on_grab_end)

func _process(delta):
	var rng = RandomNumberGenerator.new()
	if grabbed:
		position = get_global_mouse_position() + grabbed_offset
	else:
		position += delta * random_movement * Vector2(rng.randf_range(-random_movement, random_movement), rng.randf_range(-random_movement, random_movement))

func _on_mouse_entered() -> void:
	get_parent().on_hover_start(self)

func _on_mouse_exited() -> void:
	get_parent().on_hover_end(self)
