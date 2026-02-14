@tool
extends RigidBody2D
class_name RigidBodyDraggable

@export var appear_delay: float = 0
@export var random_movement: float = 30
@export var pull_spring_stiffness: float = 10
@export var max_spring_force: float = 100
@export var draggable: Draggable

var sprite_index: int = 0
var grabbed = false
var can_grab = false
var grabbed_offset = Vector2()

signal grab_start
signal grab_end

@export var sprite: Sprite2D
@export var draggable_config: DraggableResource: 
	set(new_config):
		draggable_config = new_config
		if !sprite_index:
			sprite_index = 0
		print(sprite_index)
		if new_config != null:
			sprite.texture = new_config.textures[sprite_index % len(new_config.textures)]
			_generate_collider()
@export var animations: BasicDraggableAnims

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
		#collider.owner = get_tree().edited_scene_root

func _init():
	var rng = RandomNumberGenerator.new()
	sprite_index = rng.randi()

func _ready():
	animations.appear_anim_delay = appear_delay
	if draggable_config:
		sprite.texture = draggable_config.textures[sprite_index % len(draggable_config.textures)]
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
		apply_force(-offset.normalized() * spring_force * dt, to_global(grabbed_offset) - to_global(center_of_mass))

func _on_mouse_entered() -> void:
	var cursor = get_parent()
	while cursor:
		if cursor.has_method("on_hover_start"):
			cursor.on_hover_start(draggable)
			break
		cursor = cursor.get_parent()

func _on_mouse_exited() -> void:
	var cursor = get_parent()
	while cursor:
		if cursor.has_method("on_hover_end"):
			cursor.on_hover_end(draggable)
			break
		cursor = cursor.get_parent()
