extends Node
class_name RandomMovementForce

@export var rigidbody: RigidBody2D
@export var force_intensity: float
@export var random_turn_speed: float

var _direction: float
var _rng: RandomNumberGenerator

func _ready():
	_rng = RandomNumberGenerator.new()

func _physics_process(dt: float):
	_direction += (_rng.randf()-0.5) * 2 * dt * random_turn_speed
	rigidbody.apply_force(Vector2(cos(_direction * 2 * PI), sin(_direction * 2 * PI)) * force_intensity)
