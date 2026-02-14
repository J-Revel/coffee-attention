@tool
extends Node2D
class_name DialogueSpawner

@export var character_container: Node
@export var line_count: int = 5
@export var line_height: float = 50
@export var line_width: float = 500
@export var character_prefabs: Array[PackedScene]
@export var word_length_range: Vector2i = Vector2i(3, 10)
@export var character_spawn_interval_range = Vector2(0.05, 0.09)
@export var word_interval_range: Vector2 = Vector2(0.2, 3)

@export var character_thickness_range: Vector2 = Vector2(20, 50)

var _cursor: Vector2
var _current_word_characters: int
var _t: float
var _next_character_interval: float

@onready var _rng = RandomNumberGenerator.new()

func ready():
	_current_word_characters = _rng.randi_range(word_length_range.x, word_length_range.y)

func _spawn_character(position: Vector2):
	var prefab = character_prefabs[_rng.randi() % len(character_prefabs)]
	var instance = prefab.instantiate()
	instance.global_position = position
	character_container.add_child(instance)

func _process(delta):
	_t += delta
	if _t >= _next_character_interval:
		_t -= _next_character_interval
		_current_word_characters -= 1
		_spawn_character(_cursor)
		if _current_word_characters <= 0:
			_cursor.x += _rng.randf_range(character_thickness_range.x, character_thickness_range.y) * 2
			_next_character_interval = _rng.randf_range(word_interval_range.x, word_interval_range.y)
		else:
			_cursor.x += _rng.randf_range(character_thickness_range.x, character_thickness_range.y)
			_next_character_interval = _rng.randf_range(character_spawn_interval_range.x, character_spawn_interval_range.y)
		if _cursor.x > line_width:
			_cursor.x = 0
			_cursor.y += line_height

		
	
	
