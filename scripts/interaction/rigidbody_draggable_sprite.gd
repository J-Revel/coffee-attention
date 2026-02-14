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

@export var sprite: Sprite2D
@export var texture: Texture2D

func _generate_collider():
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(sprite.texture.get_image())

	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2(0, 0), bitmap.get_size()))
		

	for polygon in polygons:
		var collider = CollisionPolygon2D.new()
		collider.polygon = polygon
		if sprite.centered:
			collider.position = -Vector2(bitmap.get_size())/2
		else:
			collider.position = sprite.position
		add_child.call_deferred(collider)
		collider.owner = get_tree().edited_scene_root

func _ready():
	sprite.texture = texture
	if texture:
		_generate_collider()
	draggable.grab_start.connect(_on_grab_start)
	draggable.grab_end.connect(_on_grab_end)

		
func _on_grab_start():
	grabbed = true
	grabbed_offset = to_local(get_global_mouse_position())

func _on_grab_end():
	grabbed = false

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
