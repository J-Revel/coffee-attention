@tool
extends Node2D
class_name DraggableCollider

@export var sprite: Sprite2D
@export var rigidbody: RigidBody2D
@export_tool_button("Generate Collider", "Callable") var generate_button = _generate_collider

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
		rigidbody.add_child.call_deferred(collider)
		collider.owner = get_tree().edited_scene_root

func _ready():
	_generate_collider()
