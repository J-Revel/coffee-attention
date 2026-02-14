extends Node
class_name BasicDraggableAnims

@onready var appear_anim_player: AnimationPlayer = %"appear_anim_player"
@onready var hover_anim_player: AnimationPlayer = %"hover_anim_player"
@onready var grab_anim_player: AnimationPlayer = %"grab_anim_player"
@export var appear_anim_delay = 0

@onready var _appear_delay = 0

func _ready():
	%draggable.hover_start.connect(_on_hover_start)
	%draggable.hover_end.connect(_on_hover_end)
	%draggable.grab_start.connect(_on_grab_start)
	%draggable.grab_end.connect(_on_grab_end)
	
func _process(delta: float):
	_appear_delay += delta
	if _appear_delay >= appear_anim_delay:
		appear_anim_player.play("appear")
		process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_hover_start():
	hover_anim_player.play("hover", -1, 1, false)
	
func _on_hover_end():
	hover_anim_player.play("hover", -1, -1, true)
	
func _on_grab_start():
	grab_anim_player.play("grab", -1, 1, false)
	
func _on_grab_end():
	grab_anim_player.play("grab", -1, -1, true)
	
