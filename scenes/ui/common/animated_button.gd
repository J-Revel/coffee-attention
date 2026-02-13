extends Button
class_name AnimatedButton


func _on_focus_entered() -> void:
	pass

func _on_focus_exited() -> void:
	pass


func _on_mouse_entered() -> void:
	var anim_player: AnimationPlayer = %anim_player
	anim_player.play("hover_start")


func _on_mouse_exited() -> void:
	var anim_player: AnimationPlayer = %anim_player
	anim_player.play("hover_end")

func _on_pressed() -> void:
	var anim_player: AnimationPlayer = %anim_player
	anim_player.stop()
	anim_player.play("press")
