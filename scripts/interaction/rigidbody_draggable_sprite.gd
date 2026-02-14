extends RigidBody2D
class_name RigidBodyDraggable

@export var random_movement: float = 30
@export var pull_spring_stiffness: float = 10
@export var max_spring_force: float = 100
@export var draggable: Draggable
var grabbed = false
var can_grab = false
var grabbed_offset = Vector2()

signal grab_start
signal grab_end

		
func _on_grab_start():
	grabbed = true
	grabbed_offset = to_local(get_global_mouse_position())

func _on_grab_end():
	grabbed = false

func _ready():
	draggable.grab_start.connect(_on_grab_start)
	draggable.grab_end.connect(_on_grab_end)

func _physics_process(dt):
	if grabbed:
		var drag_target = get_global_mouse_position()
		var offset: Vector2 = to_global(grabbed_offset) - drag_target
		var spring_force = min(offset.length() * pull_spring_stiffness, max_spring_force)
		apply_force(-offset.normalized() * spring_force * dt, to_global(grabbed_offset) - position)

func _on_mouse_entered() -> void:
	get_parent().on_hover_start(draggable)

func _on_mouse_exited() -> void:
	get_parent().on_hover_end(draggable)
