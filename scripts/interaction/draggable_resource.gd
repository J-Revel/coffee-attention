extends Resource
class_name DraggableResource

@export var textures: Array[Texture2D]:
	set(value):
		textures = value
		changed.emit()

@export var appear_delay: float
