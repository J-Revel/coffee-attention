extends Node
class_name BasicDraggableAnims

@onready var hover_anim_player: AnimationPlayer = %"hover_anim_player"
@onready var grab_anim_player: AnimationPlayer = %"grab_anim_player"

func _ready():
	hover_anim_player.play("appear")
	%draggable.hover_start.connect(_on_hover_start)
	%draggable.hover_end.connect(_on_hover_end)
	%draggable.grab_start.connect(_on_grab_start)
	%draggable.grab_end.connect(_on_grab_end)
	
func _on_hover_start():
	hover_anim_player.play("hover", -1, 1, false)
	
func _on_hover_end():
	hover_anim_player.play("hover", -1, -1, true)
	
func _on_grab_start():
	grab_anim_player.play("grab", -1, 1, false)
	
func _on_grab_end():
	grab_anim_player.play("grab", -1, -1, true)
	
