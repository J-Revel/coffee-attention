@tool
extends Node2D
class_name DialogueSpawner

@export var spawn_interval_range = Vector2(2, 10)
@export var prefabs: Array[PackedScene]
@export var container: Node
@export var spawn_bounds_min: Node2D
@export var spawn_bounds_max: Node2D

var _next_spawn_time = 0
@onready var _rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _process(dt):
	_next_spawn_time -= dt
	if _next_spawn_time < 0:
		_next_spawn_time += _rng.randf_range(spawn_interval_range.x, spawn_interval_range.y)
		var instance = prefabs[_rng.randi_range(0, len(prefabs)-1)].instantiate()
		var spawn_bounds_size = spawn_bounds_max.global_position - spawn_bounds_min.global_position
		instance.global_position = spawn_bounds_min.global_position + spawn_bounds_size * Vector2(
			_rng.randf(), _rng.randf()
		)
		container.add_child(instance)
