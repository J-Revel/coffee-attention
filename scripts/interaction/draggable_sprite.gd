extends StaticBody2D
class_name SimpleDraggable

var can_grab = false
var grabbed_offset = Vector2()
@export var random_movement: float = 30
var grabbed = false
@export var draggable: Draggable

		
func _on_grab_start():
	grabbed = true
	grabbed_offset = position - get_global_mouse_position()

func _on_grab_end():
	grabbed = false

func _ready():
	draggable.grab_start.connect(_on_grab_start)
	draggable.grab_end.connect(_on_grab_end)

func _process(delta):
	var rng = RandomNumberGenerator.new()
	if grabbed:
		position = get_global_mouse_position() + grabbed_offset
	else:
		position += delta * random_movement * Vector2(rng.randf_range(-random_movement, random_movement), rng.randf_range(-random_movement, random_movement))

func _on_mouse_entered() -> void:
	get_parent().on_hover_start(draggable)

func _on_mouse_exited() -> void:
	get_parent().on_hover_end(draggable)
